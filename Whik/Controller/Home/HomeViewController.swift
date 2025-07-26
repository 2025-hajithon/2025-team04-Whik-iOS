//
//  HomeViewController.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import UIKit
import Shuffle

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
        loadData()
    }
    
    private func setupLayout() {
        homeView.addSubview(cardStack)
        cardStack.layer.masksToBounds = false
        cardStack.snp.makeConstraints {
            $0.top.equalTo(homeView.tagStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(440)
        }
    }
    
    private func setupCardStack() {
        cardStack.delegate = self
        cardStack.dataSource = self
    }
    
    private func loadData() {
        let nickname = UserDefaults.standard.nickname ?? "게스트"
        user = User(name: nickname, matchRate: 99)
        destinations = [
            Destination(
                id: UUID().uuidString,
                koreanName: "로스엔젤레스",
                englishName: "Los Angeles",
                description: "따사로운 햇살과 해변이 매력적인 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["자연이 아름다운", "바다가 보이는", "한적한"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "김하늘", rating: 5, comment: "날씨가 정말 좋았어요! 바다도 예쁘고 힐링 그 자체~", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "이준", rating: 4, comment: "조금 더웠지만 풍경이 멋졌어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "최윤아", rating: 5, comment: "조용하고 평화로운 분위기! 다시 가고 싶어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil)
                ]
            ),
            Destination(
                id: UUID().uuidString,
                koreanName: "뉴욕",
                englishName: "New York",
                description: "문화와 예술, 음식이 풍부한 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["도시 감성", "야경이 멋진", "먹거리가 풍부한"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "정민수", rating: 3, comment: "사람이 너무 많아서 정신없었지만, 그게 또 매력!", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "장예린", rating: 4, comment: "센트럴파크에서 산책 정말 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil)
                ]
            ),
            Destination(
                id: UUID().uuidString,
                koreanName: "교토",
                englishName: "Kyoto",
                description: "고즈넉한 분위기와 전통이 살아있는 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["감성 숙소", "산책하기 좋은", "강이 흐르는"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "최윤아", rating: 5, comment: "조용하고 평화로운 분위기! 다시 가고 싶어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "정민수", rating: 3, comment: "사람이 너무 많아서 정신없었지만, 그게 또 매력!", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "장예린", rating: 4, comment: "센트럴파크에서 산책 정말 좋았어요.", date: Date(), imageName: nil)
                ]
            ),Destination(
                id: UUID().uuidString,
                koreanName: "뉴욕",
                englishName: "New York",
                description: "문화와 예술, 음식이 풍부한 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["도시 감성", "야경이 멋진", "먹거리가 풍부한"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "정민수", rating: 3, comment: "사람이 너무 많아서 정신없었지만, 그게 또 매력!", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "장예린", rating: 4, comment: "센트럴파크에서 산책 정말 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil)
                ]
            ),Destination(
                id: UUID().uuidString,
                koreanName: "뉴욕",
                englishName: "New York",
                description: "문화와 예술, 음식이 풍부한 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["도시 감성", "야경이 멋진", "먹거리가 풍부한"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "정민수", rating: 3, comment: "사람이 너무 많아서 정신없었지만, 그게 또 매력!", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "장예린", rating: 4, comment: "센트럴파크에서 산책 정말 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil)
                ]
            ),Destination(
                id: UUID().uuidString,
                koreanName: "뉴욕",
                englishName: "New York",
                description: "문화와 예술, 음식이 풍부한 도시입니다.",
                imageURL: nil,
                imageName: "sampleImage",
                tags: ["도시 감성", "야경이 멋진", "먹거리가 풍부한"],
                reviews: [
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "정민수", rating: 3, comment: "사람이 너무 많아서 정신없었지만, 그게 또 매력!", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "장예린", rating: 4, comment: "센트럴파크에서 산책 정말 좋았어요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "홍길동", rating: 4, comment: "전통과 현대가 어우러진 느낌이 좋아요.", date: Date(), imageName: nil),
                    Review(id: UUID().uuidString, userName: "박서연", rating: 5, comment: "브로드웨이 공연 최고였어요! 먹거리도 다양해서 좋았어요.", date: Date(), imageName: nil)
                ]
            )
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
        let destination = destinations[index]
        let card = DestinationCard(frame: .zero, destination: destination)
        
        card.onTap = { [weak self] in
            let detailVC = DestinationDetailModalViewController(destination: destination)
            detailVC.modalPresentationStyle = .pageSheet
            self?.present(detailVC, animated: true)
        }
        
        card.onSelectIconTapped = { [weak self] in
            guard let self = self else { return }
            
            let destination = self.destinations[index]
            let probability = Double.random(in: 0.2...0.999) // 예시 확률 (0.1% ~ 1%)
            
            let modal = DestinationFoundModalViewController(
                destinationName: destination.koreanName,
                probability: probability
            )
            
            self.present(modal, animated: true, completion: nil)
        }
        
        return card
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        switch direction {
        case .left:
            print("❌ 싫어요 - \(destinations[index].englishName)")
        case .right:
            print("❤️ 좋아요 - \(destinations[index].englishName)")
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
