//
//  RedditService.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import Foundation

class RedditService: NetworkService {
    init() {}
    
    func fetchPosts(completion: @escaping (Result<[RedditPost], Error>) -> Void) {
        let url = URL(string: "\(Constants.REDDIT_API_URL)/\(Constants.REDDIT_POPULAR_POSTS_PATH)")
        
        performRequest(
            url: url,
            method: .get
        ) { (result: Result<RedditResponse, Error>) in
            switch result {
            case .success(let response):
                let posts = response.data.children.map { $0.data }
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
