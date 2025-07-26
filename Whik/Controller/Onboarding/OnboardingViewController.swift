//
//  OnboardingViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class OnboardingViewController: UIViewController {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let progressView = UIProgressView(progressViewStyle: .default).then {
        $0.progressTintColor = .whikPrimary
        $0.trackTintColor = .lightGray
        $0.setProgress(0.0, animated: false)
        $0.layer.cornerRadius = 5
        $0.transform = CGAffineTransform(scaleX: 1.0, y: 2.5)
        $0.clipsToBounds = true
    }
    
    private let containerView = UIView()
    
    private let nextButton = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .Style.body1
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .whikPrimary
        $0.layer.cornerRadius = 25
    }
    
    private var currentStep: Int = 0
    
    private var selectedTags: Set<String> = []
    
    private let steps: [UIView] = [
        NicknameInputView(),
//        CitySelectView(),
        KeywordSelectView(),
        ConfirmView()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        showCurrentStep()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(logoImageView, progressView, containerView, nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(4)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-12)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(50)
        }
    }
    
    private func showCurrentStep() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        let stepView = steps[currentStep]
        containerView.addSubview(stepView)
        stepView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        let isConfirmStep = stepView is ConfirmView
        progressView.isHidden = isConfirmStep
        nextButton.isHidden = isConfirmStep
        
        if !progressView.isHidden {
            let progressSteps = steps.filter { !($0 is ConfirmView) }.count
            let currentVisibleIndex = min(currentStep, progressSteps - 1)
            progressView.setProgress(Float(currentVisibleIndex + 1) / Float(progressSteps), animated: true)
        }
        
        if currentStep == 1 {
            nextButton.setTitle("완료", for: .normal)
        } else {
            nextButton.setTitle("다음", for: .normal)
        }
        
        if let keywordView = stepView as? KeywordSelectView {
            keywordView.onTagTapped = { [weak self] button in
                self?.handleTagSelection(for: button)
            }
            
            keywordView.configureTags([
                "음식이 담백한", "배고픔", "자연", "야경", "사람 많은", "응애", "오션뷰", "온천", "랜드마크"
            ])
        }
        
        // ConfirmView일 경우: 온보딩 완료 저장 + 3초 뒤 메인으로 이동
        if isConfirmStep {
            // TODO: 사용자 정보 저장하며, 서버로 정보 넘겨주기
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
        
        print("✅ 현재 선택된 태그: \(selectedTags)")
    }
    
    @objc private func nextButtonTapped() {
        if currentStep < steps.count - 1 {
            currentStep += 1
            showCurrentStep()
        } else {
            // TODO: 마지막 단계일 경우 서버에 UUID + 정보 전달
        }
    }
    
    private func navigateToMain() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
}
