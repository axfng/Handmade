//
//  Product.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation


struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let tags: [String]
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, thumbnail, tags
    }
}
