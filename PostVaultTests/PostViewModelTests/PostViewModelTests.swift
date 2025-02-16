//
//  PostViewModelTests.swift
//  PostVaultTests
//
//  Created by Dishant Choudhary on 16/02/25.
//

import XCTest
import RxSwift
import RxCocoa

@testable import PostVault

class PostViewModelTests: XCTestCase {

    var viewModel: PostViewModel!
    var mockAPIService: MockAPIService!
    var mockDatabaseService: MockDatabaseService!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockDatabaseService = MockDatabaseService()
        viewModel = PostViewModel(apiService: mockAPIService, dbService: mockDatabaseService)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockDatabaseService = nil
        disposeBag = nil
        super.tearDown()
    }

    /// Test fetching posts successfully
    func testFetchPosts_Success() {
        let expectation = XCTestExpectation(description: "Fetch posts successfully")

        let mockPost = Post(id: 1, title: "Test Post", body: "This is a test", userId: 1, isFavorite: false)
        mockAPIService.mockPosts = [mockPost]

        viewModel.fetchPosts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.posts.value.count, 1)
            XCTAssertEqual(self.viewModel.posts.value.first?.title, "Test Post")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    /// Test fetching posts when API fails (fallback to local DB)
    func testFetchPosts_Failure() {
        let expectation = XCTestExpectation(description: "Fallback to local database on API failure")

        mockAPIService.shouldFail = true //  Ensure API fails
        mockAPIService.mockPosts = []

        let cachedPost = Post(id: 2, title: "Cached Post", body: "Stored in DB", userId: 1, isFavorite: false)
        mockDatabaseService.storedPosts = [cachedPost] // Ensure DB has cached posts

        viewModel.fetchPosts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.posts.value.count, 1, "Expected cached post from DB")
            XCTAssertEqual(self.viewModel.posts.value.first?.title, "Cached Post", "Expected correct cached post title")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    /// Test toggling favorite updates database
    func testToggleFavorite() {
        let post = Post(id: 3, title: "Fav Post", body: "Favorite Me", userId: 1, isFavorite: false)
        mockDatabaseService.storedPosts = [post]
        viewModel.refreshPosts()

        viewModel.toggleFavorite(post: post)

        XCTAssertTrue(mockDatabaseService.storedPosts.first?.isFavorite ?? false)
    }

    /// Test refreshPosts loads posts from database
    func testRefreshPosts() {
        let cachedPost = Post(id: 4, title: "Old Post", body: "From DB", userId: 1, isFavorite: false)
        mockDatabaseService.storedPosts = [cachedPost]

        viewModel.refreshPosts()

        XCTAssertEqual(viewModel.posts.value.count, 1)
        XCTAssertEqual(viewModel.posts.value.first?.title, "Old Post")
    }

    /// Test refreshFavorites loads only favorite posts
    func testRefreshFavorites() {
        let favPost = Post(id: 5, title: "Loved Post", body: "I am Favorited", userId: 1, isFavorite: true)
        let normalPost = Post(id: 6, title: "Normal Post", body: "I am not Favorited", userId: 1, isFavorite: false)
        mockDatabaseService.storedPosts = [favPost, normalPost]

        viewModel.refreshFavorites()

        XCTAssertEqual(viewModel.favorites.value.count, 1)
        XCTAssertEqual(viewModel.favorites.value.first?.title, "Loved Post")
    }

    /// Test fetching comments successfully
    func testFetchComments_Success() {
        let expectation = XCTestExpectation(description: "Fetch comments successfully")

        let comment = Comment(postId: 1, id: 1, name: "Commenter", email: "test@example.com", body: "Nice post!")
        mockAPIService.mockComments = [comment]

        var receivedComments: [Comment] = []
        
        // Capture emitted values using subscription
        viewModel.commentsRelay.subscribe(onNext: { comments in
            receivedComments = comments
            expectation.fulfill()
        }).disposed(by: disposeBag)

        viewModel.fetchComments(for: 1)

        wait(for: [expectation], timeout: 2.0)
        
        // Check emitted comments
        XCTAssertEqual(receivedComments.count, 1)
        XCTAssertEqual(receivedComments.first?.body, "Nice post!")
    }

    /// Test fetching comments when API fails (fallback to local DB)
    func testFetchComments_Failure() {
        let expectation = XCTestExpectation(description: "Fetch comments failed, fallback to cached data")

        let cachedComment = Comment(postId: 1, id: 2, name: "Cached User", email: "cached@example.com", body: "Cached comment")
        mockDatabaseService.storedComments = [cachedComment]

        var receivedComments: [Comment] = []
        
        // Subscribe and capture emitted values
        viewModel.commentsRelay.subscribe(onNext: { comments in
            receivedComments = comments
            expectation.fulfill()
        }).disposed(by: disposeBag)

        mockAPIService.shouldFail = true  // Simulate API failure
        viewModel.fetchComments(for: 1)

        wait(for: [expectation], timeout: 2.0)

        // Validate fallback to cached comments
        XCTAssertEqual(receivedComments.count, 1)
        XCTAssertEqual(receivedComments.first?.body, "Cached comment")
    }
}
