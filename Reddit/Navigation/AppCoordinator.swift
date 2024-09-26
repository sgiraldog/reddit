//
//  AppCoordinator.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import UIKit

class AppCoordinator: NavigatedCoordinator {
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let postsViewController = PostsViewController(viewModel: PostsViewModel())
        navigationController.setViewControllers([postsViewController], animated: false)
    }
    
    func navigateToPosts() {
        let postsViewController = PostsViewController(viewModel: PostsViewModel())
        navigationController.pushViewController(postsViewController, animated: true)
    }
    
    func navigateToPostDetails(post: RedditPost) {
        let postDetailsViewController = PostDetailsViewController(viewModel: PostDetailsViewModel(post: post))
        navigationController.pushViewController(postDetailsViewController, animated: true)
    }
}
