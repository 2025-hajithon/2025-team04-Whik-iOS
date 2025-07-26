//
//  MyPageView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class MyPageView: UIView {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "userImage")
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "이든"
        $0.font = .Style.body1
        $0.textColor = .black
    }
    
    private let editButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.tintColor = .darkGray
    }
    
    private let settingButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "gear"), for: .normal)
        $0.tintColor = .darkGray
    }
    
    private let nicknameStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let profileStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
    }
    
    let likedTitleLabel = UILabel().then {
        $0.text = "내가 좋아한 여행지"
        $0.font = .Style.headline
        $0.textColor = .black
    }
    
    let destinationCollectionView = DestinationCollectionView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        nicknameStack.addArrangedSubviews(nicknameLabel, editButton, settingButton)
        profileStack.addArrangedSubviews(profileImageView, nicknameStack)
        addSubviews(logoImageView, profileStack, likedTitleLabel, destinationCollectionView)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        
        profileStack.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        likedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(profileStack.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        
        destinationCollectionView.snp.makeConstraints {
            $0.top.equalTo(likedTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(480)
        }
    }
}
