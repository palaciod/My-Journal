//
//  JournalApi.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/4/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation


struct JournalApi{
    private let keyChain = KeychainSwift()
    func login(email: String, password: String, loginViewController: LoginViewController){
        let jsonUrlString = "http://localhost:5000/users/login"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        
                        //self.keyChain.set(user.passport.user, forKey: "userID")
                        self.keyChain.set(data, forKey: "userID")
                        DispatchQueue.main.async(execute: {
                            let mainViewController = MainViewController()
                            mainViewController.userSession = user
                            loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                        })
                    }catch let jsonError {
                        print("Error serializing json:",jsonError)
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    func logout(mainViewController: MainViewController){
        keyChain.delete("userID")
        URLSession.shared.reset {
            print("Successfully signout")
            DispatchQueue.main.async {
                mainViewController.navigationController?.setViewControllers([LoginViewController()], animated: true)
            }
        }
        
    }
    
    func signInStatus(loginViewController: LoginViewController){
        let data = keyChain.getData("userID")
        let cookies = HTTPCookieStorage.shared.cookies
        if !cookies!.isEmpty {
            do{
                print("User is signed in")
                let user = try JSONDecoder().decode(UserSession.self, from: data!)
                let mainViewController = MainViewController()
                mainViewController.userSession = user
                loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
            }catch let jsonError {
                print("Error serializing json:",jsonError)
                
            }
        }else {
            print("User is not signed in")
        }
        
        
    }
    
    
    func register(email: String, password: String, name: String, loginViewController: LoginViewController){
        let jsonUrlString = "http://localhost:5000/users/register"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password, "name":name]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard data != nil else {return}
                    self.login(email: email.lowercased(), password: password, loginViewController: loginViewController)
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func get(id: String){
        let jsonUrlString = "http://localhost:5000/posts/\(id)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let user = try JSONDecoder().decode(Post.self, from: data)
                    print("<---------\(user.title)---------->")
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func getAllPosts(main: MainViewController,id: String){
        let jsonUrlString = "http://localhost:5000/posts/\(id)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    main.posts = posts
                    print("<---------\(posts)---------->")
                    print("This is the current size of the array: \(posts.count)")
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func createNewPost(id: String, title: String, journalEntry: String){
        let jsonUrlString = "http://localhost:5000/posts/create/\(id)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["title":title,"entry":journalEntry,"user":id]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func deletePost(id: String){
        DispatchQueue.main.async {
            let jsonUrlString = "http://localhost:5000/posts/delete/\(id)"
            guard let url = URL(string: jsonUrlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                print("Successfully deleted post.")
                
                }.resume()
        }
    }
    
    func editPost(postID: String, title: String, journalEntry: String){
        let jsonUrlString = "http://localhost:5000/posts/edit/\(postID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["title":title,"entry":journalEntry]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
}
