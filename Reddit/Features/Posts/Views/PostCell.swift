//
//  PostCell.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import UIKit

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    private let titleLabel = UILabel()
    private let postImageView = UIImageView()
    private let upvotesLabel = UILabel()
    private let commentsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, postImageView, upvotesLabel, commentsLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with post: RedditPost, imageLoaded: @escaping () -> Void) {
        titleLabel.text = post.title
        upvotesLabel.text = "Upvotes: \(post.ups)"
        commentsLabel.text = "Comments: \(post.numComments)"
        
        if let url = post.url, !url.isEmpty {
            postImageView.load(url) { [weak self] image in
                guard let self, let image else {
                    return
                }
                
                if image.size.width > 0 &&  image.size.height > 0 {
                    let widthRatio = CGFloat(image.size.width / image.size.height)
                    NSLayoutConstraint.activate([
                        postImageView.widthAnchor.constraint(equalToConstant: image.size.width),
                        postImageView.heightAnchor.constraint(equalToConstant: image.size.width > contentView.frame.width ? contentView.frame.width / widthRatio : image.size.height)
                    ])
                    postImageView.isHidden = false
                } else {
                    NSLayoutConstraint.activate([
                        postImageView.widthAnchor.constraint(equalToConstant: 0),
                        postImageView.heightAnchor.constraint(equalToConstant: 0)
                    ])
                    postImageView.isHidden = true
                }
                imageLoaded()
            }
        } else {
            postImageView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset the content to default state
        titleLabel.text = nil
        upvotesLabel.text = nil
        commentsLabel.text = nil
        
        // Reset the image view's image
        postImageView.image = nil
        postImageView.isHidden = true
    }
}
