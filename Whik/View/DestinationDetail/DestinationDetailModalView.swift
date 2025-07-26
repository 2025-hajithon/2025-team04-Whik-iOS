//
//  DestinationDetailModalView.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class DestinationDetailModalView: UIView {

    // MARK: - UI

    private let titleLabel = UILabel().then {
        $0.font = .Style.headline
        $0.textColor = .black
    }

    private let subtitleLabel = UILabel().then {
        $0.font = .Style.body2
        $0.textColor = .gray
    }

    private let descriptionLabel = UILabel().then {
        $0.font = .Style.body1
        $0.textColor = .gray
        $0.numberOfLines = 0
    }

    private let reviewCountLabel = UILabel().then {
        $0.font = .Style.body2
        $0.textColor = .gray
    }

    let reviewStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with destination: Destination) {
        titleLabel.text = destination.koreanName
        subtitleLabel.text = "\(destination.englishName)\n\(destination.tags.first ?? "")"
        descriptionLabel.text = destination.description
        reviewCountLabel.text = "\(destination.reviews.count)개의 후기"

        reviewStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        destination.reviews.forEach { review in
            let reviewView = ReviewView()
            reviewView.configure(with: review)
            reviewStackView.addArrangedSubview(reviewView)
        }
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            titleLabel,
            subtitleLabel,
            descriptionLabel,
            reviewCountLabel,
            reviewStackView
        )

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        reviewCountLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(reviewCountLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
