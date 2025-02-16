//
//  APIService.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Alamofire
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func fetchPosts() -> Observable<[Post]>
    func fetchComments(for postId: Int) -> Observable<[Comment]>
}

class APIService: APIServiceProtocol {
    
    // Base URL for API requests
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    /// Fetches posts (GET request).
    func fetchPosts() -> Observable<[Post]> {
        return request(endpoint: "/posts", method: .get)
    }
    
    /// Fetches comments for a given post ID (GET request).
    func fetchComments(for postId: Int) -> Observable<[Comment]> {
        return request(endpoint: "/posts/\(postId)/comments", method: .get)
    }
    
    /// Generic request method to handle both GET and POST requests.
    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) -> Observable<T> {
        let url = "\(baseURL)\(endpoint)"
        
        return Observable.create { observer in
            let request = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            // Ensure disposal of request when observer is deallocated
            return Disposables.create { request.cancel() }
        }
    }
}
