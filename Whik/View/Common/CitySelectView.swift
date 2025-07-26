//
//  CitySelectView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

//import UIKit
//import SnapKit
//import Then
//
//struct City: Equatable {
//    let name: String
//    let imageName: String
//    let englishName: String
//
//    static let sampleCities: [City] = [
//        .init(name: "도쿄", imageName: "tokyo", englishName: "Tokyo"),
//        .init(name: "서울", imageName: "seoul", englishName: "Seoul"),
//        .init(name: "코타키나발루", imageName: "kotakinabalu", englishName: "Kota Kinabalu"),
//        .init(name: "오사카", imageName: "osaka", englishName: "Osaka"),
//        .init(name: "방콕", imageName: "bangkok", englishName: "Bangkok")
//    ]
//}
//
//final class CitySelectView: UIView {
//
//    private let titleLabel = UILabel().then {
//        $0.text = "이전 여행 장소를 등록해주세요"
//        $0.font = .Style.headline
//        $0.textColor = .black
//    }
//
//    private let searchBar = UISearchBar().then {
//        $0.placeholder = "검색어"
//        $0.searchBarStyle = .minimal
//
//        $0.backgroundColor = .systemGray6
//        $0.layer.cornerRadius = 20
//        $0.layer.masksToBounds = true
//
//        // 내부 텍스트필드 커스터마이징
//        let textField = $0.searchTextField
//        textField.backgroundColor = .clear
//        textField.layer.cornerRadius = 0
//        textField.borderStyle = .none
//    }
//
//
//    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
//        layout?.scrollDirection = .vertical
//        layout?.minimumLineSpacing = 16
//        layout?.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 160)
//
//        $0.register(CityCell.self, forCellWithReuseIdentifier: CityCell.id)
//        $0.dataSource = self
//        $0.delegate = self
//        $0.backgroundColor = .white
//    }
//
//    private let cities = City.sampleCities
//    private var filteredCities: [City] = City.sampleCities
//    private var selectedCities: [City] = []
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        searchBar.delegate = self
//        addSubviews(titleLabel, searchBar, collectionView)
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupLayout() {
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(40)
//            $0.left.right.equalToSuperview().inset(20)
//        }
//
//        searchBar.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
//            $0.left.right.equalToSuperview().inset(20)
//            $0.height.equalTo(44)
//        }
//
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(searchBar.snp.bottom).offset(20)
//            $0.left.right.bottom.equalToSuperview().inset(20)
//        }
//    }
//}
//
//// MARK: - CollectionView
//extension CitySelectView: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filteredCities.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath) as? CityCell else {
//            return UICollectionViewCell()
//        }
//        let city = filteredCities[indexPath.item]
//        let isSelected = selectedCities.contains(city)
//        cell.configure(with: city, selected: isSelected)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let city = filteredCities[indexPath.item]
//        if let index = selectedCities.firstIndex(of: city) {
//            selectedCities.remove(at: index)
//        } else {
//            selectedCities.append(city)
//        }
//        collectionView.reloadItems(at: [indexPath])
//    }
//}
//
//// MARK: - Search
//extension CitySelectView: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredCities = cities
//        } else {
//            filteredCities = cities.filter {
//                $0.name.localizedCaseInsensitiveContains(searchText) ||
//                $0.englishName.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//        collectionView.reloadData()
//    }
//}
