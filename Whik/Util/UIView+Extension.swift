//
//  UIView+Extension.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
