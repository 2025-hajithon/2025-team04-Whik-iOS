//
//  OnboardingViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingView = OnboardingView()
    
    private var categoryMap: [String: String] = [:]
    
    private var currentStep: Int = 0
    private var selectedTags: Set<String> = []
    
    private let steps: [UIView] = [
        NicknameInputView(),
        KeywordSelectView(),
        ConfirmView()
    ]
    
    override func loadView() {
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        showCurrentStep()
    }
    
    private func showCurrentStep() {
        onboardingView.containerView.subviews.forEach { $0.removeFromSuperview() }
        let stepView = steps[currentStep]
        onboardingView.containerView.addSubview(stepView)
        stepView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        let isConfirmStep = stepView is ConfirmView
        onboardingView.progressView.isHidden = isConfirmStep
        onboardingView.nextButton.isHidden = isConfirmStep
        
        if !onboardingView.progressView.isHidden {
            let progressSteps = steps.filter { !($0 is ConfirmView) }.count
            let currentVisibleIndex = min(currentStep, progressSteps - 1)
            onboardingView.progressView.setProgress(Float(currentVisibleIndex + 1) / Float(progressSteps), animated: true)
        }
        
        onboardingView.nextButton.setTitle(currentStep == 1 ? "완료" : "다음", for: .normal)
        
        if let keywordView = stepView as? KeywordSelectView {
            keywordView.onTagTapped = { [weak self] button in
                self?.handleTagSelection(for: button)
            }
            
            // MARK: 카테고리 리스트 가져오기
            NetworkManager.shared.get(path: "/categories") { [weak self] (result: Result<[CategoryModel], Error>) in
                switch result {
                case .success(let categories):
                    let tagNames = categories.map { $0.value }
                    self?.categoryMap = categories.reduce(into: [:]) { result, item in
                        if result[item.value] == nil {
                            result[item.value] = item.category
                        }
                    }
                    keywordView.configureTags(tagNames)
                    
                case .failure(let error):
                    print("❌ 태그 목록 로딩 실패:", error)
                }
            }
            
        }
        
        if isConfirmStep {
            UserDefaults.standard.hasCompletedOnboarding = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.navigateToMain()
            }
        }
    }
    
    private func handleTagSelection(for button: UIButton) {
        guard let tag = button.title(for: .normal)?.replacingOccurrences(of: "#", with: "") else { return }
        
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
            button.backgroundColor = .systemGray3
            button.setTitleColor(.white, for: .normal)
        } else {
            selectedTags.insert(tag)
            button.backgroundColor = .whikPrimary
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func nextButtonTapped() {
        switch currentStep {
        case 0:
            guard let nicknameView = steps[0] as? NicknameInputView else { return }
            let nickname = nicknameView.nickname.trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard !nickname.isEmpty else {
                print("⚠️ 닉네임이 비어있습니다.")
                return
            }
            
            // MARK: POST 멤버 등록
            NetworkManager.shared.postStringBody(
                path: "/members",
                body: nickname
            ) { [weak self] (result: Result<MemberResponse, Error>) in
                switch result {
                case .success(let response):
                    print("✅ memberId 저장됨:", response.memberId)
                    UserDefaults.standard.memberId = response.memberId
                    UserDefaults.standard.nickname = nickname /// 닉네임도 저장
                    
                    self?.currentStep += 1
                    self?.showCurrentStep()
                    
                case .failure(let error):
                    print("❌ 멤버 생성 실패:", error.localizedDescription)
                }
            }
            
        case 1:
            // MARK: 태그 선택 → 서버에 POST /member-categories
            guard let memberId = UserDefaults.standard.memberId else {
                print("❌ memberId 없음")
                return
            }
            
            let selectedCategoryCodes = selectedTags.compactMap { categoryMap[$0] }
            
            let request = MemberCategoryRequest(
                memberId: memberId,
                categories: selectedCategoryCodes
            )
            
            // MARK: 카테고리 등록 POST
            NetworkManager.shared.postWithoutDecoding(
                path: "/member-categories",
                body: request
            ) { [weak self] result in
                switch result {
                case .success:
                    print("✅ 카테고리 등록 성공")
                    self?.currentStep += 1
                    self?.showCurrentStep()
                case .failure(let error):
                    print("❌ 카테고리 등록 실패:", error.localizedDescription)
                }
            }

        default:
            break
        }
    }
    
    private func navigateToMain() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
}
