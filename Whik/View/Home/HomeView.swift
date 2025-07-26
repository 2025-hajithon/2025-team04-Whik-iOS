//
//  HomeView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class HomeView: UIView {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let toggleButton = ToggleButton()
    
    private lazy var topStackView = UIStackView(arrangedSubviews: [logoImageView, UIView(), toggleButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
        $0.distribution = .fill
    }
    
    let recommendationLabel = UILabel().then {
        $0.text = ""
        $0.font = .Style.headline
        $0.numberOfLines = 2
    }
    
    let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubviews(topStackView, recommendationLabel, tagStackView)
        
        topStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
        
        toggleButton.snp.makeConstraints {
            $0.height.equalTo(32)
        }
        
        recommendationLabel.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(recommendationLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
    }
    
    func configureHeader(user: User, tags: [String]) {
        recommendationLabel.text = "\(user.name)님의 이전 여행지와\n\(user.matchRate)% 일치하는"
        configureTags(tags)
    }
    
    func configureTags(_ tags: [String]) {
        tagStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        tagStackView.alignment = .leading
        tagStackView.distribution = .fill
        
        tags.forEach { tag in
            let tagView = TagView(
                title: tag,
                textColor: .white,
                backgroundColor: randomTagColor()
            )
            tagStackView.addArrangedSubview(tagView)
        }
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        tagStackView.addArrangedSubview(spacer)
    }
    
    private func randomTagColor() -> UIColor {
        let colors: [UIColor] = [.systemBlue, .systemPink, .systemGreen, .systemOrange, .systemTeal]
        return colors.randomElement() ?? .systemGray
    }
}
