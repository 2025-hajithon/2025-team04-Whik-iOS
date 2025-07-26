//
//  UIStackView+Extension.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
