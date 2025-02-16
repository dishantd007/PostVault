//
//  PostRealmModel.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import RealmSwift

class PostRealmModel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var userId: Int
    @Persisted var isFavorite: Bool = false  // Track favorite status

    // Convert Realm Model to Standard Model
    func toPost() -> Post {
        return Post(id: id, title: title, body: body, userId: userId, isFavorite: isFavorite)
    }
}

