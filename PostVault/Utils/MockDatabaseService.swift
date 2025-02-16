//
//  MockDatabaseService.swift
//  PostVaultTests
//
//  Created by Dishant Choudhary on 16/02/25.
//

import RxSwift
import RxCocoa

class MockDatabaseService: DatabaseServiceProtocol {
    var storedPosts: [Post] = []
    var storedFavorites: [Post] = []
    var storedComments: [Comment] = []

    func getAllPosts() -> [Post] {
        return storedPosts
    }

    func savePosts(_ posts: [Post]) {
        storedPosts = posts
    }

    func toggleFavorite(post: Post) {
        if let index = storedPosts.firstIndex(where: { $0.id == post.id }) {
            storedPosts[index].isFavorite?.toggle()
        }
    }

    func getFavoritePosts() -> [Post] {
        return storedPosts.filter { $0.isFavorite ?? false }
    }

    func getComments(for postId: Int) -> [Comment] {
        return storedComments
    }

    func saveCommentsToRealm(_ comments: [Comment]) {
        storedComments = comments
    }
}
