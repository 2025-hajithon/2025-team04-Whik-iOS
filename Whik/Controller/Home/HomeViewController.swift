//
//  HomeViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import Shuffle

// MARK: - Models

struct User {
    let name: String
    let matchRate: Int
}

struct Destination {
    let imageName: String
    let tags: [String]
    let koreanName: String
    let englishName: String
}

final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private let cardStack = SwipeCardStack()
    private var user: User!
    private var destinations: [Destination] = []
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCardStack()
        loadMockData()
    }
    
    private func setupLayout() {
        homeView.addSubview(cardStack)
        cardStack.layer.masksToBounds = false
        cardStack.snp.makeConstraints {
            $0.top.equalTo(homeView.tagStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func setupCardStack() {
        cardStack.delegate = self
        cardStack.dataSource = self
    }
    
    private func loadMockData() {
        user = User(name: "이든", matchRate: 99)
        destinations = [
            Destination(imageName: "sampleImage", tags: ["자연이 아름다운", "바다가 보이는", "한적한"], koreanName: "로스엔젤레스", englishName: "Los Angeles"),
            Destination(imageName: "sampleImage", tags: ["도시 감성", "야경이 멋진", "먹거리가 풍부한"], koreanName: "뉴욕", englishName: "New York"),
            Destination(imageName: "sampleImage", tags: ["감성 숙소", "산책하기 좋은", "강이 흐르는"], koreanName: "교토", englishName: "Kyoto"),
        ]
        
        homeView.configureHeader(user: user, tags: destinations.first?.tags ?? [])
        cardStack.reloadData()
    }
}

extension HomeViewController: SwipeCardStackDataSource, SwipeCardStackDelegate {
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return destinations.count
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return DestinationCard(frame: .zero, destination: destinations[index])
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        switch direction {
        case .left:
            print("❌ 싫어요 - \(destinations[index].englishName)")
        case .right:
            print("❤️ 좋아요 - \(destinations[index].englishName)")
        case .up:
            print("✅ 선택 완료 - \(destinations[index].englishName)")
        default:
            break
        }
        
        if index + 1 < destinations.count {
            homeView.configureTags(destinations[index + 1].tags)
        }
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("✅ 모든 추천이 끝났습니다.")
    }
}
