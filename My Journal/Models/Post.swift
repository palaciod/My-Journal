//
//  Post.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/5/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct Post: Decodable{
    let date: String
    let _id: String
    let title: String
    let entry: String
    let user: String
}
