//
//  CollectionPostCell.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/5/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class CollectionPostCell: UICollectionViewCell {
    var postID: String?
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title?"
        //xsschool.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    let journalEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Entry?"
        //xsschool.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    let bottomView: EditDeleteView = {
        let bottom = EditDeleteView()
        bottom.translatesAutoresizingMaskIntoConstraints = false
        return bottom
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        self.addSubview(journalEntryLabel)
        self.addSubview(bottomView)
        setTitleLabel()
        setJournalEntryLabel()
        setUpBottomView()
    }
    private func setTitleLabel(){
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
    }
    private func setJournalEntryLabel(){
        journalEntryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        journalEntryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        journalEntryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        journalEntryLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        journalEntryLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func setUpBottomView(){
        bottomView.topAnchor.constraint(equalTo: journalEntryLabel.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: journalEntryLabel.trailingAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.60).isActive = true
        bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
