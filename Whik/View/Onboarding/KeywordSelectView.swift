//
//  KeywordSelectView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class KeywordSelectView: UIView {

    var onTagTapped: ((UIButton) -> Void)?

    private let titleLabel = UILabel().then {
        $0.text = "선호 키워드를 선택해주세요"
        $0.font = .Style.headline
        $0.textColor = .black
        $0.numberOfLines = 2
    }

    private let tagWrapContainer = UIView()

    private(set) var tagButtons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(titleLabel, tagWrapContainer)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        tagWrapContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0) // 초기값 명시
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

    func configureTags(_ tags: [String]) {
        tagButtons.forEach { $0.removeFromSuperview() }
        tagButtons = []
        tagWrapContainer.subviews.forEach { $0.removeFromSuperview() }

        let containerWidth = UIScreen.main.bounds.width - 40
        let spacing: CGFloat = 8
        let lineSpacing: CGFloat = 8

        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxHeight: CGFloat = 0

        for tag in tags {
            let button = UIButton(type: .system).then { button in
                button.setTitle("#\(tag)", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemGray3
                button.titleLabel?.font = .Style.captionMedium
                button.layer.cornerRadius = 14
                button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

                button.addAction(UIAction { [weak self] _ in
                    print("✅ 태그 탭됨:", tag)
                    self?.onTagTapped?(button)
                }, for: .touchUpInside)
            }

            tagButtons.append(button)
            tagWrapContainer.addSubview(button)

            let buttonWidth = "#\(tag)".size(withAttributes: [.font: UIFont.Style.captionMedium]).width + 24
            let buttonHeight: CGFloat = 28

            if currentX + buttonWidth > containerWidth && currentX > 0 {
                currentX = 0
                currentY += maxHeight + lineSpacing
                maxHeight = 0
            }

            button.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(currentX)
                $0.top.equalToSuperview().offset(currentY)
            }

            currentX += buttonWidth + spacing
            maxHeight = max(maxHeight, buttonHeight)
        }

        let totalHeight = currentY + maxHeight
        tagWrapContainer.snp.updateConstraints {
            $0.height.equalTo(totalHeight)
        }
    }
}
