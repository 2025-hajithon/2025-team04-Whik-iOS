//
//  UIFont+Style.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit.UIFont

extension UIFont {
    enum Pretendard {
        static func black(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
        }
        static func extraBold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .heavy)
        }
        static func bold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        }
        static func semiBold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        static func medium(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        }
        static func regular(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
        static func light(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        }
        static func extraLight(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
        }
        static func thin(_ size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-Thin", size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
        }
    }
    
    enum Style {
        static let title = Pretendard.semiBold(24)
        static let headline = Pretendard.semiBold(20)
        static let subhead = Pretendard.semiBold(18)
        static let body1 = Pretendard.medium(16)
        static let body2 = Pretendard.medium(14)
        static let captionSemibold = Pretendard.semiBold(12)
        static let captionMedium = Pretendard.medium(12)
    }
}
