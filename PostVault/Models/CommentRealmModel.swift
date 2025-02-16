//
//  CommentRealmModel.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Foundation
import RealmSwift

class CommentRealmModel: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var postId: Int
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var body: String

    // Default initializer required by Realm
    override init() { 
        super.init()
    }

    convenience init(id: Int, postId: Int, name: String, email: String, body: String) {
        self.init()
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
    
    // Convert Realm Model to Standard Model
    func toComment() -> Comment {
        return Comment(postId: postId, id: id, name: name, email: email, body: body)
    }
}
