//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import Foundation
import Resolver

class PostsViewModel {
    
    // MARK: View State
    
    enum ViewState {
        case loading
        case error
        case loaded([RedditPost])
    }
    
    // MARK: View Actions
    
    enum ViewAction {
        case onPostSelected(Int)
        case loadPosts
    }
    
    // MARK: Dependencies
    
    
    @Injected private var redditService: RedditService
    @Injected private var appCoordinator: AppCoordinator
    
    // MARK: Properties
    
    @Published var viewState: ViewState = .loading
    
    // MARK: Action Handling
    
    func handleAction(_ action: ViewAction) {
        switch action {
        case let .onPostSelected(index):
            presentPostDetails(index: index)
        case .loadPosts:
            loadPosts()
        }
    }
    
    private func presentPostDetails(index: Int?) {
        guard let index, case let .loaded(posts) = viewState else {
            return
        }
        
        appCoordinator.navigateToPostDetails(post: posts[index])
    }
    
    private func loadPosts() {
        redditService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.viewState = .loaded(posts)
                case .failure(_):
                    self?.viewState = .error
                }
            }
        }
    }
}
