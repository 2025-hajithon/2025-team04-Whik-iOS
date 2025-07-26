//
//  DestinationFoundModalViewController.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

import UIKit

final class DestinationFoundModalViewController: UIViewController {

    private let destinationName: String
    private let probability: Double
    private let modalView = DestinationFoundModalView()

    init(destinationName: String, probability: Double) {
        self.destinationName = destinationName
        self.probability = probability
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = modalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.configure(destinationName: destinationName, probability: probability)
        modalView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
