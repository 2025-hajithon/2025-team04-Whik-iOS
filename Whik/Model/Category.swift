//
//  Category.swift
//  Whik
//
//  Created by Eden on 7/27/25.
//

struct CategoryModel: Decodable {
    let category: String
    let value: String
}

struct MemberCategoryRequest: Encodable {
    let memberId: String
    let categories: [String]
}

struct VoidResponse: Decodable {}
