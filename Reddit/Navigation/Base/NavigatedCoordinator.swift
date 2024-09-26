//
//  NavigatedCoordinator.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import UIKit

protocol NavigatedCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

extension NavigatedCoordinator {
    func popCurrentScene(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootScene(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}
