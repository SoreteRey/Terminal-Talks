//
//  HomeScreenViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/9/23.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var PostTableView: UITableView!
    
    var models = [SkySocialPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        PostTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        PostTableView.delegate = self
        PostTableView.dataSource = self
        
        models.append(SkySocialPost(peopleOnTheirWay: 2, username: "SeaBass", userImageName: "head", postImageName: "post1"))
        models.append(SkySocialPost(peopleOnTheirWay: 5, username: "Scotty", userImageName: "head2", postImageName: "post2"))
        models.append(SkySocialPost(peopleOnTheirWay: 0, username: "Chase", userImageName: "head", postImageName: "post3"))
        models.append(SkySocialPost(peopleOnTheirWay: 0, username: "Orco", userImageName: "head2", postImageName: "head2"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0 + 0 + view.frame.size.width
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

struct SkySocialPost {
    let peopleOnTheirWay: Int
    let username: String
    let userImageName: String //this are the images.
    let postImageName: String //this is an image check later if they are in the correct format
}
