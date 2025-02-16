//
//  PostViewModel.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import RxSwift
import RxCocoa

class PostViewModel {
    
    // MARK: - Dependencies
    /// API service for fetching posts and comments
    private let apiService: APIServiceProtocol
    /// Local database service (Realm)
    private let dbService: DatabaseServiceProtocol
    /// RxSwift DisposeBag for memory management
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive Properties
    /// Emits list of posts (from API or cache)
    let posts = BehaviorRelay<[Post]>(value: [])
    /// Emits list of favorite posts
    let favorites = BehaviorRelay<[Post]>(value: [])
    /// Emits list of comments for a post
    let commentsRelay = PublishRelay<[Comment]>()
    
    // MARK: - Initializer
    init(apiService: APIServiceProtocol = APIService(), dbService: DatabaseServiceProtocol = DatabaseService()) {
        self.apiService = apiService
        self.dbService = dbService
        observeNetworkChanges()
    }

    // MARK: - API & Database Operations
        
    /// Fetch posts from API, fallback to local DB if needed
    func fetchPosts() {
        let cachedPosts = self.dbService.getAllPosts()
        if !cachedPosts.isEmpty {
            self.posts.accept(cachedPosts)
        }
        
        self.apiService.fetchPosts()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] posts in
                let localPosts = self?.dbService.getAllPosts() ?? []
                
                // Merge API data with local favorites
                let mergedPosts = posts.map { post in
                    let localPost = localPosts.first(where: { $0.id == post.id })
                    return Post(id: post.id,
                                title: post.title,
                                body: post.body,
                                userId: post.userId,
                                isFavorite: localPost?.isFavorite ?? false)
                }
                
                ///save updated posts in db
                self?.dbService.savePosts(mergedPosts)
                self?.posts.accept(mergedPosts)
            }, onError: { [weak self] error in
                print("Failed to fetch posts: \(error.localizedDescription)")
                // If network fails, load from local DB
                self?.posts.accept(self?.dbService.getAllPosts() ?? [])
            })
            .disposed(by: disposeBag)
    }
    
    /// Refresh posts list from DB
    /// useful after a local update
    func refreshPosts() {
        self.posts.accept(dbService.getAllPosts())
    }
    
    /// Toggle favorite state of a post and update UI
    func toggleFavorite(post: Post) {
        self.dbService.toggleFavorite(post: post)
        self.refreshPosts()
        self.refreshFavorites()
    }
    
    /// Refresh favorite posts list from DB
    func refreshFavorites() {
        self.favorites.accept(dbService.getFavoritePosts())
    }
}

extension PostViewModel {
    /// Fetch comments from API for a specific post, fallback to cached comments if needed
    func fetchComments(for postId: Int) {
        self.apiService.fetchComments(for: postId)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {[weak self] comment in
                self?.dbService.saveCommentsToRealm(comment)
                self?.commentsRelay.accept(comment)
            } onError: {[weak self] error in
                print("Failed to fetch comments: \(error.localizedDescription)")
                let cachedComments = self?.dbService.getComments(for: postId) ?? []
                self?.commentsRelay.accept(cachedComments)
            }
            .disposed(by: disposeBag)
    }
    
    /// Observe network changes and reload when online
    private func observeNetworkChanges() {
        NetworkMonitor.shared.isInternetAvailable
            .observe(on: MainScheduler.asyncInstance)
            .distinctUntilChanged() // Only trigger when state changes
            .filter { $0 } // Only reload when internet is back
            .subscribe(onNext: { [weak self] _ in
                print("🌐 Internet restored! Reloading posts...")
                self?.fetchPosts()
            })
            .disposed(by: disposeBag)
    }
}
