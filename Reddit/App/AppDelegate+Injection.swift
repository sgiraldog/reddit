//
//  AppDelegate+Injection.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    @MainActor
    public static func registerAllServices() {
        register { AppCoordinator() }.scope(.application)
        register { RedditService() }.scope(.application)
    }
}
