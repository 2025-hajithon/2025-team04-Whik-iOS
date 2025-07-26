//
//  MyPageViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "마이페이지 화면입니다."
        label.textColor = .black
        label.font = .Style.headline
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setLayout()
    }

    private func setUI() {
        view.addSubview(label)
    }

    private func setLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
