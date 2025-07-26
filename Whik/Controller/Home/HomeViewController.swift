//
//  HomeViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "초기세팅 테스트 입니다."
        label.textColor = .whikPrimary
        label.font = .Style.body1
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.addSubview(testLabel)
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        testLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(150)
        }
    }
}
