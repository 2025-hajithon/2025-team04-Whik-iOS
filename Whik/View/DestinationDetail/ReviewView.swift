//
//  ReviewView.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class ReviewView: UIView {
    
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .Style.body2
        $0.textColor = .black
    }
    
    private let starLabel = UILabel().then {
        $0.font = .Style.body2
        $0.textColor = .systemOrange
    }
    
    private let commentLabel = UILabel().then {
        $0.font = .Style.captionMedium
        $0.textColor = .darkGray
        $0.numberOfLines = 0
    }
    
    private let containerStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .top
    }
    
    private let textStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with review: Review) {
        nameLabel.text = review.userName
        starLabel.text = String(repeating: "★", count: review.rating)
        commentLabel.text = review.comment
        let image = UIImage(named: review.imageName ?? "userImage")
        profileImageView.image = image
    }
    
    private func setupLayout() {
        addSubview(containerStack)
        containerStack.addArrangedSubviews(profileImageView, textStack)
        textStack.addArrangedSubviews(nameLabel, starLabel, commentLabel)
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        containerStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
