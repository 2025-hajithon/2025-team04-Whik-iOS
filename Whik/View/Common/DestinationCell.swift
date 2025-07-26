//
//  DestinationCell.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class DestinationCell: UICollectionViewCell {

    static let id = "DestinationCell"

    private let thumbnailImageView = UIImageView().then {
        $0.image = UIImage(named: "sampleImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }

    private let gradientOverlayView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
    }

    private let gradientLayer = CAGradientLayer()

    private let nameLabelKR = UILabel().then {
        $0.font = .Style.headline
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
    }

    private let nameLabelEN = UILabel().then {
        $0.font = .Style.captionSemibold
        $0.textColor = .white.withAlphaComponent(0.9)
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
    }

    private let nameStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.25

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        setupGradient()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientOverlayView.layer.addSublayer(gradientLayer)

        contentView.addSubviews(thumbnailImageView, gradientOverlayView, nameStack)
        nameStack.addArrangedSubviews(nameLabelKR, nameLabelEN)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setNeedsLayout()
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(roundedRect: contentView.frame, cornerRadius: 12).cgPath

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = gradientOverlayView.bounds
        CATransaction.commit()
    }

    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        gradientOverlayView.snp.makeConstraints {
            $0.edges.equalTo(thumbnailImageView)
        }

        nameStack.snp.makeConstraints {
            $0.leading.trailing.equalTo(thumbnailImageView).inset(20)
            $0.bottom.equalTo(thumbnailImageView).inset(16)
            $0.height.lessThanOrEqualTo(60)
        }
    }

    func configure(with destination: Destination) {
        thumbnailImageView.image = UIImage(named: destination.imageName)
        nameLabelKR.text = destination.koreanName
        nameLabelEN.text = destination.englishName

        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.gradientLayer.frame = self.gradientOverlayView.bounds
            CATransaction.commit()
        }
    }
}
