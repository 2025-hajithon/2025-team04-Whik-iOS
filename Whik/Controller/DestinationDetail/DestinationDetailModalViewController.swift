//
//  DestinationDetailModalViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

final class DestinationDetailModalViewController: UIViewController {
    
    private let destination: Destination
    private let detailView = DestinationDetailModalView()
    
    init(destination: Destination) {
        self.destination = destination
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        detailView.configure(with: destination)
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                return context.maximumDetentValue * 0.9
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
    }
}
