//
//  PostDetailsViewModel.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import Foundation
import Resolver

class PostDetailsViewModel: ObservableObject {
    
    // MARK: View State
    
    enum ViewState {
        case loaded(RedditPost)
    }
    
    // MARK: View Actions
    
    enum ViewAction {}
    
    // MARK: Dependencies
    
    
    @Injected private var redditService: RedditService
    @Injected private var appCoordinator: AppCoordinator
    
    // MARK: Properties
    
    @Published var viewState: ViewState
    
    init(post: RedditPost) {
        viewState = .loaded(post)
    }
    
    // MARK: Action Handling
    
    func handleAction(_ action: ViewAction) {}
}
