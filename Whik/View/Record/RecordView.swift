//
//  RecordView.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class RecordView: UIView {
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whikLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "검색어"
        $0.searchBarStyle = .minimal
        
        
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        
        // 내부 텍스트필드 커스터마이징
        let textField = $0.searchTextField
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 0
        textField.borderStyle = .none
    }
    
    let destinationCollectionView = DestinationCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubviews(logoImageView, searchBar, destinationCollectionView)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        destinationCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(520)
        }
    }
}
