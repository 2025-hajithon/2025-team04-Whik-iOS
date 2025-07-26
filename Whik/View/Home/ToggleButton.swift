//
//  ToggleButton.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class ToggleButton: UIButton {

    private let circleView = UIView()
    private let label = UILabel()

    private var isToggled: Bool = true
    private var circleLeadingConstraint: Constraint?
    private var circleTrailingConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setSelected(isToggled)
        addTarget(self, action: #selector(toggleState), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        layer.cornerRadius = 16
        clipsToBounds = true

        addSubviews(circleView, label)

        circleView.do {
            $0.layer.cornerRadius = 12
        }

        label.do {
            $0.font = .Style.captionSemibold
        }

        circleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            // 초기 제약조건은 leading만 설정
            circleLeadingConstraint = $0.leading.equalToSuperview().offset(4).constraint
        }

        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(circleView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(32)
        }
    }

    @objc private func toggleState() {
        isToggled.toggle()
        setSelected(isToggled)
    }

    func setSelected(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = .whikPrimary
            circleView.backgroundColor = .white
            label.textColor = .white
            label.text = "비슷한"

            circleView.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(24)
                $0.leading.equalToSuperview().offset(4)
            }

            label.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(circleView.snp.trailing).offset(4)
                $0.trailing.equalToSuperview().inset(8)
            }
        } else {
            backgroundColor = .whikBlue
            circleView.backgroundColor = .white
            label.textColor = .white
            label.text = "색다른"

            circleView.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(24)
                $0.trailing.equalToSuperview().inset(4)
            }

            label.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(8)
                $0.trailing.equalTo(circleView.snp.leading).offset(-4)
            }
        }

        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
