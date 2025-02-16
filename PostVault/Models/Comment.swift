//
//  Comment.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

