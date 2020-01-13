//
//  PostViewController.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/7/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    var userSession: UserSession?
    var posts: [Post]?
    var targetMethod: String?
    var index: Int?
    let navBar: NavBar = {
        let navbar = NavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.rightButton.setTitle("Post", for: .normal)
        navbar.leftButton.setTitle("Cancel", for: .normal)
        return navbar
    }()
    
    private let post: EditablePostView = {
        let post = EditablePostView()
        post.translatesAutoresizingMaskIntoConstraints = false
        return post
    }()
    private let journalApi = JournalApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar)
        view.addSubview(post)
        setUpNavBar()
        setUpPost()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("PostViewController released from memory.")
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to right and left navbar buttons
        navBar.leftButton.addTarget(self, action: #selector(cancelPost), for: .touchUpInside)
        navBar.rightButton.addTarget(self, action: #selector(postIt), for: .touchUpInside)
    }
    
    private func setUpPost(){
        post.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        post.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        post.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    @objc private func cancelPost(){
        let mainViewController = MainViewController()
        mainViewController.userSession = self.userSession
        mainViewController.posts = self.posts
        self.navigationController?.setViewControllers([mainViewController], animated: true)
    }
    @objc private func postIt(){
        let title = post.titleTextField.text ?? ""
        let entry = post.entryTextView.text ?? ""
        let userID = userSession!.passport.user
        if targetMethod! == "post" {
            journalApi.createNewPost(id: userID, title: title, journalEntry: entry)
            print("post")
        }else{
            print("edit")
            let postID = posts?[index!]._id
            journalApi.editPost(postID: postID!, title: title, journalEntry: entry)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let mainViewController = MainViewController()
            mainViewController.userSession = self.userSession
            mainViewController.posts = self.posts
            self.navigationController?.setViewControllers([mainViewController], animated: true)
        }
    }
    
    
    

}
