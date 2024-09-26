//
//  PostDetailsView.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import SwiftUI

struct PostDetailsView: View {
    @ObservedObject var viewModel: PostDetailsViewModel
    
    var body: some View {
        switch viewModel.viewState {
        case .loaded(let post):
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    if let imageUrl = post.url, let url = URL(string: imageUrl) {
                        imageView(url: url)
                    }
                    Text(post.title)
                        .font(.title)
                        .bold()
                    if let body = post.body, !body.isEmpty {
                        Text(body)
                            .font(.subheadline)
                    }
                    upvotesView(post: post)
                    commentsView(post: post)
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    func imageView(url: URL) -> some View {
        AsyncImage(url: url) { image in
            image.resizable().aspectRatio(contentMode: .fit)
        } placeholder: {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func upvotesView(post: RedditPost) -> some View {
        HStack(spacing: 4) {
            Text("Upvotes")
                .bold()
            Text("\(post.ups)")
        }
        .font(.subheadline)
    }
    
    func commentsView(post: RedditPost) -> some View {
        HStack(spacing: 4) {
            Text("Comments")
                .bold()
            Text("\(post.numComments)")
        }
        .font(.subheadline)
    }
}
