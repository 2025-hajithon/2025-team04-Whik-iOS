//
//  Destination.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import Foundation

struct Destination {
    let id: String
    let koreanName: String
    let englishName: String
    let description: String
    let imageURL: String?
    let imageName: String
    let tags: [String]
    let reviews: [Review]
}

struct Review {
    let id: String
    let userName: String
    let rating: Int // 1-5
    let comment: String
    let date: Date
    let imageName: String?
}
