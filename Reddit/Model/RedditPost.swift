//
//  RedditPost.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import Foundation

struct RedditPost: Codable {
    let title: String
    let body: String?
    let ups: Int
    let numComments: Int
    let thumbnail: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case ups
        case numComments = "num_comments"
        case thumbnail
        case body = "selftext"
        case url
    }
}

struct RedditResponse: Codable {
    let data: RedditData
    
    struct RedditData: Codable {
        let children: [RedditChild]
        
        struct RedditChild: Codable {
            let data: RedditPost
        }
    }
}
