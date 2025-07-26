//
//  ConfirmView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit

final class ConfirmView: UIView {
    
    private let pickImageView = UIImageView().then {
        $0.image = UIImage(named: "pickImage")
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel().then {
        $0.text = "설정이 완료되었어요!"
        $0.font = .Style.title
        $0.textColor = .black
        $0.textAlignment = .center
    }

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogoPrimary")
        $0.contentMode = .scaleAspectFit
    }

    private let subtitleLabel = UILabel().then {
        $0.text = "을 시작해볼까요?"
        $0.font = .Style.title
        $0.textColor = .black
        $0.textAlignment = .left
    }

    private lazy var horizontalStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.addArrangedSubviews(logoImageView, subtitleLabel)
    }

    private lazy var verticalStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 16
        $0.addArrangedSubviews(pickImageView, titleLabel, horizontalStack)
    }

    private var hasSetConstraints = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        backgroundColor = .white
        addSubview(verticalStack)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if !hasSetConstraints {
            verticalStack.snp.makeConstraints {
                $0.center.equalToSuperview()
            }

            pickImageView.snp.makeConstraints {
                $0.height.equalTo(100)
            }
            
            logoImageView.snp.makeConstraints {
                $0.width.equalTo(52)
                $0.height.equalTo(20)
            }

            hasSetConstraints = true
        }
    }
}

