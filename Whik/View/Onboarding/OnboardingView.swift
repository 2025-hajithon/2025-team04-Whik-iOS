//
//  OnboardingView.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class OnboardingView: UIView {
    
    // MARK: - UI Components
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    let progressView = UIProgressView(progressViewStyle: .default).then {
        $0.progressTintColor = .whikPrimary
        $0.trackTintColor = .lightGray
        $0.setProgress(0.0, animated: false)
        $0.layer.cornerRadius = 5
        $0.transform = CGAffineTransform(scaleX: 1.0, y: 2.5)
        $0.clipsToBounds = true
    }
    
    let containerView = UIView()
    
    let nextButton = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .Style.body1
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .whikPrimary
        $0.layer.cornerRadius = 25
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(logoImageView, progressView, containerView, nextButton)
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
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
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(50)
        }
    }
}
