//
//  Post.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Foundation

// Standard API Post Model
struct Post: Codable {
    let id: Int?
    let title: String?
    let body: String?
    var userId: Int?
    var isFavorite: Bool? = false
}
