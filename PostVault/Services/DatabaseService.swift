//
//  DatabaseService.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import RealmSwift
import RxSwift
import RxCocoa

protocol DatabaseServiceProtocol {
    func getAllPosts() -> [Post]
    func savePosts(_ posts: [Post])
    func toggleFavorite(post: Post)
    func getFavoritePosts() -> [Post]
    func saveCommentsToRealm(_ comments: [Comment])
    func getComments(for postId: Int) -> [Comment]
}

class DatabaseService: DatabaseServiceProtocol {
    
    // MARK: - Properties
    private let realm: Realm?
    
    /// Observable Relay to track favorite posts in real-time
    let favoritesRelay = BehaviorRelay<[Post]>(value: [])
    
    // MARK: - Initializer
    init() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
            realm = nil
        }
    }
    
    
    // MARK: - Post Management

    /// Saves posts to Realm while preserving the `isFavorite` state.
    /// - Parameter posts: Get array of posts from API and save to Realm
    func savePosts(_ posts: [Post]) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                for post in posts {
                    if let existingPost = realm.object(ofType: PostRealmModel.self, forPrimaryKey: post.id) {
                        // If a post with the same ID exists, update title & body (keeping isFavorite unchanged)
                        existingPost.title = post.title ?? ""
                        existingPost.body = post.body ?? ""
                        existingPost.userId = post.userId ?? 0
                    } else {
                        let realmPost = PostRealmModel()
                        realmPost.id = post.id ?? 0
                        realmPost.title = post.title ?? ""
                        realmPost.body = post.body ?? ""
                        realmPost.userId = post.userId ?? 0
                        realmPost.isFavorite = false  // New post defaults to non-favorite
                        realm.add(realmPost, update: .modified)
                    }
                }
            }
            favoritesRelay.accept(getFavoritePosts()) // ✅ Ensure relay holds updated favorites
        } catch {
            print("Error saving posts to Realm: \(error.localizedDescription)")
        }
    }
    
    /// Retrieves all posts from Realm.
    /// - Returns: fetch list of posts from realm database
    func getAllPosts() -> [Post] {
        guard let realm = realm else { return [] }
        return realm.objects(PostRealmModel.self).map { $0.toPost() }
    }
    
    // MARK: - Favorites Management

    /// Toggles the favorite status of a post and updates `favoritesRelay`
    /// - Parameter post: Data model for Posts
    func toggleFavorite(post: Post) {
        guard let realm = realm else { return }
        if let realmPost = realm.object(ofType: PostRealmModel.self, forPrimaryKey: post.id) {
            do {
                try realm.write {
                    realmPost.isFavorite.toggle()
                }
                let updatedFavorites = getFavoritePosts()
                print("Favorites Updated in DB: \(updatedFavorites.map { $0.title })")
                /// Emot updated favourites
                favoritesRelay.accept(updatedFavorites)
            } catch {
                print("Error updating favorite status: \(error.localizedDescription)")
            }
        }
    }
    
    /// Fetches all favorite posts from Realm.
    /// - Returns: Favorite POST model
    func getFavoritePosts() -> [Post] {
        guard let realm = realm else { return [] }
        return realm.objects(PostRealmModel.self)
            .filter("isFavorite == true")
            .map { $0.toPost() }
    }
    
    // MARK: - Comment Management

    /// Saves comments to Realm for offline support.
    /// - Parameter comments: Comments data Model
    func saveCommentsToRealm(_ comments: [Comment]) {
        guard let realm = realm else { return }
        do {
            let realmComments = comments.map { comment in
                let realmComment = CommentRealmModel()
                realmComment.body = comment.body
                realmComment.email = comment.email
                realmComment.id = comment.id
                realmComment.name = comment.name
                realmComment.postId = comment.postId
                return realmComment
            }
            
            try realm.write {
                realm.add(realmComments, update: .modified)
            }
        } catch {
            print("Error saving comments to Realm: \(error.localizedDescription)")
        }
    }
    
    /// Retrieves all comments for a specific post.
    /// - Parameter postId: Post Id for which comment needs to be fetched
    /// - Returns: Array of comments for particular Post Id
    func getComments(for postId: Int) -> [Comment] {
        guard let realm = realm else { return [] }
        return Array(realm.objects(CommentRealmModel.self).filter("postId == %@", postId)).map({ $0.toComment() })
    }
    
    // MARK: - Database Management
    
    /// Clears the entire database.
    func clearDatabase() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("Error clering database: \(error.localizedDescription)")
        }
    }
}
