//
//  DestinationFoundModalView.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class DestinationFoundModalView: UIView {
    
    // MARK: - UI Components
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    private let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "foundIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let messageLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = .whikWhite
    }
    
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let closeButton = UIButton(type: .system).then {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.whikPrimary
        $0.titleLabel?.font = .Style.body1
        $0.layer.cornerRadius = 24
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(destinationName: String, probability: Double) {
        let percentText = String(format: "%.3f%%", probability)
        let fullText = "\(destinationName)을\n\(percentText) 확률로 만났어요!"
        
        let attributed = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: percentText) {
            let nsRange = NSRange(range, in: fullText)
            attributed.addAttribute(.foregroundColor, value: UIColor.systemRed, range: nsRange)
            attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: nsRange)
        }
        
        messageLabel.attributedText = attributed
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubviews(dimmedView, contentStackView, closeButton)
        contentStackView.addArrangedSubviews(iconImageView, messageLabel)
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        messageLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(48)
        }
    }
}
