//
//  EditDeleteView.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/5/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class EditDeleteView: UIView {
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        button.setTitle("DELETE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(deleteButton)
        self.addSubview(editButton)
        setUpDeleteButton()
        setUpEditButton()
    }
    
    private func setUpDeleteButton(){
        deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.40).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        deleteButton.layer.cornerRadius = 10
    }
    
    private func setUpEditButton(){
        editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.40).isActive = true
        editButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        editButton.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
