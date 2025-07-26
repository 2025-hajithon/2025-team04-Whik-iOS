//
//  NicknameInputView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class NicknameInputView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 설정해주세요"
        label.font = .Style.headline
        label.textColor = .black
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.font = .Style.body1
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    var nickname: String {
        return textField.text ?? ""
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubviews(
            titleLabel,
            textField
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
    }
}
