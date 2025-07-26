//
//  MyPageViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

final class MyPageViewController: UIViewController {

    private let myPageView = MyPageView()

    override func loadView() {
        self.view = myPageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

