//
//  TabBarController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let record = UINavigationController(rootViewController: RecordViewController())
        let home = UINavigationController(rootViewController: HomeViewController())
        let myPage = UINavigationController(rootViewController: MyPageViewController())
        
        // MARK: 탭바 아이템 설정
        record.tabBarItem = makeTabItem(title: "기록", imageName: "recordIcon")
        myPage.tabBarItem = makeTabItem(title: "마이페이지", imageName: "mypageIcon")
        
        // 홈 탭만 간격 더 띄움
        let homeItem = makeTabItem(title: "홈", imageName: "homeIcon")
        homeItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 12, right: 0)
        homeItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6)
        home.tabBarItem = homeItem
        
        viewControllers = [record, home, myPage]
        selectedIndex = 1
        
        tabBar.tintColor = .whikPrimary
        tabBar.unselectedItemTintColor = .systemGray3
        tabBar.backgroundColor = .white
        
        let tabFont = UIFont.Style.body1
        let attributes: [NSAttributedString.Key: Any] = [
            .font: tabFont
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    // MARK: 공통 탭바 아이템 생성 메서드
    private func makeTabItem(title: String, imageName: String) -> UITabBarItem {
        let item = UITabBarItem(
            title: title,
            image: UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        )
        /// 아이콘과 텍스트 간격 조절
        item.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: 6, right: 0)
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        return item
    }
}
