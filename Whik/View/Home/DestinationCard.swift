//
//  SwipableCardView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Shuffle
import Then

final class DestinationCard: SwipeCard {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let titleStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    private let koreanLabel = UILabel().then {
        $0.font = .Style.headline
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    private let englishLabel = UILabel().then {
        $0.font = .Style.body2
        $0.textColor = .gray
        $0.numberOfLines = 1
    }
    
    init(frame: CGRect, destination: Destination) {
        super.init(frame: frame)
        setupLayout()
        imageView.image = UIImage(named: destination.imageName)
        koreanLabel.text = destination.koreanName
        englishLabel.text = destination.englishName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubviews(imageView, titleStack)
        titleStack.addArrangedSubviews(koreanLabel, englishLabel)
        
        koreanLabel.setContentHuggingPriority(.required, for: .vertical)
        englishLabel.setContentHuggingPriority(.required, for: .vertical)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.0)
        }
        
        titleStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
        }
    }
    
}
