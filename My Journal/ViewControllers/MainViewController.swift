//
//  MainViewController.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/5/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var userSession: UserSession?
    var posts: [Post]?
    private let navBar: NavBar = {
        let navbar = NavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionPostCell.self, forCellWithReuseIdentifier: "postCell")
        return collectionView
    }()
    private let journalApi = JournalApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main COntroller has been reinstiated ......")
        journalApi.getAllPosts(main: self, id: userSession!.passport.user)
        view.addSubview(navBar)
        setUpNavBar()
        loadPosts()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("MainViewController released from memory.")
    }
    
    private func loadPosts(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setUpCollectionView()
        }
    }
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.rightButton.addTarget(self, action: #selector(toNewPost), for: .touchUpInside)
        navBar.leftButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // Temp print method to check if i can obtain posts in journal api
    @objc private func toNewPost(){
        let newPostViewController = PostViewController()
        newPostViewController.userSession = userSession
        newPostViewController.posts = posts
        newPostViewController.targetMethod = "post"
        collectionView.delegate = nil
        collectionView.dataSource = nil
        navigationController?.setViewControllers([newPostViewController], animated: true)
    }
    
    @objc private func logout(){
        journalApi.logout(mainViewController: self)
    }
    
  
   
    

}


extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.height * 0.45)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! CollectionPostCell
        postCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        postCell.layer.cornerRadius = 5
        // Define index
        let index = indexPath[1]
        // Define Post ID
        let postID = posts?[index]._id ?? "No ID"
        // Define Title
        let title = posts?[index].title ?? "No Title"
        // Define Entry
        let journalEntry = posts?[index].entry ?? "No Journal Entry"
        
        
        setPostCellTitle(title: title, postCell: postCell)
        setPostCellJournalEntry(entry: journalEntry, postCell: postCell)
        setPostID(id: postID, postCell: postCell)
        
        // Delete Post
        deleteButtonTarget(button: postCell.bottomView.deleteButton, index: index)
        editButtonTarget(button: postCell.bottomView.editButton, index: index)
        return postCell
    }
    
    private func setPostCellTitle(title: String, postCell: CollectionPostCell){
        postCell.titleLabel.text = title
    }
    private func setPostCellJournalEntry(entry: String, postCell: CollectionPostCell){
        postCell.journalEntryLabel.text = entry
    }
    private func setPostID(id: String, postCell: CollectionPostCell){
        postCell.postID = id
    }
    private func deleteButtonTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
    }
    
    private func editButtonTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(editPost), for: .touchUpInside)
    }
    
    @objc private func deletePost(sender: UIButton){
        let index = sender.tag
        let indexPath: [IndexPath] = [[0,index]]
        let postID = posts?[index]._id ?? "404"
        journalApi.deletePost(id: postID)
        posts?.remove(at: index)
        collectionView.deleteItems(at: indexPath)
        updateButtonTags()
    }
    @objc private func editPost(sender: UIButton){
        let index = sender.tag
        let postViewController = PostViewController()
        postViewController.userSession = userSession
        postViewController.posts = posts
        postViewController.targetMethod = "edit"
        postViewController.index = index
        collectionView.delegate = nil
        collectionView.dataSource = nil
        navigationController?.setViewControllers([postViewController], animated: true)
    }
    
    private func updateButtonTags(){
        var count = posts!.count - 1
        for cell in collectionView.visibleCells{
            let postCell = cell as! CollectionPostCell
            postCell.bottomView.deleteButton.tag = count
            count -= 1
        }
    }
    
    
}
