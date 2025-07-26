//
//  TagView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class TagView: UIView {

    private let label = UILabel().then {
        $0.font = .Style.captionMedium
        $0.textAlignment = .center
        $0.textColor = .white
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    init(title: String, textColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: .zero)

        label.text = title
        label.textColor = textColor
        self.backgroundColor = backgroundColor

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        layer.cornerRadius = 14
        clipsToBounds = true

        addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(28)
        }

        // 콘텐츠 크기에 맞게 조정되도록 설정
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
