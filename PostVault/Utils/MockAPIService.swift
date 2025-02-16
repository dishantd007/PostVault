//
//  MockAPIService.swift
//  PostVaultTests
//
//  Created by Dishant Choudhary on 16/02/25.
//

import RxSwift
import RxCocoa

class MockAPIService: APIServiceProtocol {
    var mockPosts: [Post] = []
    var mockComments: [Comment] = []
    var shouldFail = false  // Simulate success or failure

    func fetchPosts() -> Observable<[Post]> {
        if shouldFail {
            return Observable.error(NSError(domain: "API Error", code: -1, userInfo: nil))
        }
        return Observable.just(mockPosts)
    }

    func fetchComments(for postId: Int) -> Observable<[Comment]> {
        if shouldFail {
            return Observable.error(NSError(domain: "API Error", code: -1, userInfo: nil))
        }
        return Observable.just(mockComments)
    }
}
