//
//  RecordViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

final class RecordViewController: UIViewController {

    private let recordView = RecordView()

    override func loadView() {
        self.view = recordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    private func configureCollectionView() {
        
    }
}
