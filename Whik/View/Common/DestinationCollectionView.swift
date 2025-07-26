//
//  DestinationCollectionView.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit
import SnapKit
import Then

final class DestinationCollectionView: UICollectionView {

    // MARK: - Properties

    private let destinations: [Destination] = [
        Destination(id: "1", koreanName: "도쿄", englishName: "Tokyo", description: "도쿄", imageURL: nil, imageName: "tokyo", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
        Destination(id: "2", koreanName: "서울", englishName: "Seoul", description: "서울", imageURL: nil, imageName: "seoul", tags: [], reviews: []),
    ]

    // MARK: - Init

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40 - 8) / 2, height: 200)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8

        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(DestinationCell.self, forCellWithReuseIdentifier: DestinationCell.id)
    }
}

// MARK: - UICollectionViewDataSource

extension DestinationCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DestinationCell.id, for: indexPath) as? DestinationCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: destinations[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DestinationCollectionView: UICollectionViewDelegate {}
