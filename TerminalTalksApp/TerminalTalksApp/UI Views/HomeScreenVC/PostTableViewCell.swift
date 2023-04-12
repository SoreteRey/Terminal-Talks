//
//  PostTableViewCell.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/11/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let peopleOnTheirWayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews to the cell's content view
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(peopleOnTheirWayLabel)
        contentView.addSubview(postImageView)
        
        // Set up layout constraints for the UI components
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        peopleOnTheirWayLabel.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // User image view constraints
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Username label constraints
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // People on their way label constraints
            peopleOnTheirWayLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            peopleOnTheirWayLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            
            // Post image view constraints
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: SkySocialPost) {
        // Set up the UI components with the post data
        userImageView.image = UIImage(named: post.userImageName)
        usernameLabel.text = post.username
        peopleOnTheirWayLabel.text = "\(post.peopleOnTheirWay) On their way"
        postImageView.image = UIImage(named: post.postImageName)
    }
}
