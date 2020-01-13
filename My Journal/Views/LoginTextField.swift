//
//  LoginTextField.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/4/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class LoginTextField: UIView {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        return textField
    }()
    private let passwordTextField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.layer.cornerRadius = 5
        return passwordField
    }()
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        space.backgroundColor = #colorLiteral(red: 0.7317958474, green: 0.7119134068, blue: 0.708604455, alpha: 1)
        return space
    }()
    private let textFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 1
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextFieldContainer()
        self.addSubview(emailTextField)
        self.addSubview(blankSpace)
        self.addSubview(passwordTextField)
        setUpEmailTextField()
        setUpBlankSpace()
        setUpPasswordTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpEmailTextField(){
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.49).isActive = true
    }
    
    private func setUpBlankSpace(){
        blankSpace.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blankSpace.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.01).isActive = true
    }
    private func setUpPasswordTextField(){
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.49).isActive = true
    }
    
    private func setUpTextFieldContainer(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
    }
    
}
