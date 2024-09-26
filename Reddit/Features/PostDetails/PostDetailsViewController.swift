//
//  PostDetailsViewController.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import SwiftUI

class PostDetailsViewController: UIHostingController<PostDetailsView> {
    
    init(viewModel: PostDetailsViewModel) {
        super.init(rootView: PostDetailsView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Post Details"
    }
}
