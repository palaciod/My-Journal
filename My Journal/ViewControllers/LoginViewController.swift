//
//  LoginViewController.swift
//  My Journal
//
//  Created by Daniel Palacio on 12/30/19.
//  Copyright © 2019 Daniel Palacio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    /**
     This is an optional constraint. This is meant to change the the constraint value of the text field container text field.
     */
    var textFieldfContainerHeightAnchor: NSLayoutConstraint?
    /**
     This is an optional constraint. This is meant to change the the constraint value of the email text field.
     */
    var emailTextFieldHeightConstraint: NSLayoutConstraint?
    /**
     This is an optional constraint. This is meant to change the the constraint value of the password text field.
     */
    var passwordTextFieldHeightConstraint: NSLayoutConstraint?
    var reTypedPasswordTextFieldHeightConstraint: NSLayoutConstraint?
    
    private let appIcon: UIImageView = {
        var logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "myJournalAppIcon")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let blankSpace: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(items: ["Login","Register"])
        segControl.selectedSegmentIndex = 0
        segControl.tintColor = #colorLiteral(red: 0.7058823529, green: 0, blue: 0.3176470588, alpha: 1)
        segControl.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.4823529412, blue: 0.7450980392, alpha: 1)
        segControl.addTarget(self, action: #selector(loginOrRegister), for: .valueChanged)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return segControl
    }()
    private let textFieldsContainer: UIView = {
        let textFields = UIView()
        textFields.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textFields.layer.borderWidth = 1.0
        textFields.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textFields.translatesAutoresizingMaskIntoConstraints = false
        textFields.layer.cornerRadius = 5
        return textFields
    }()
    let reTypedPasswordTextField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Retype Password"
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let passwordTextField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let myJournalApi = JournalApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        myJournalApi.signInStatus(loginViewController: self)
        view.addSubview(appIcon)
        view.addSubview(blankSpace)
        view.addSubview(segmentedControl)
        view.addSubview(textFieldsContainer)
        view.addSubview(loginRegisterButton)
        setUpTextFieldContainer()
        setUpSegmentedControl()
        setUpLoginRegisterButton()
        setUpBlankSpace()
        setUpAppIcon()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setUpAppIcon(){
        appIcon.bottomAnchor.constraint(equalTo: blankSpace.topAnchor).isActive = true
        appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        appIcon.heightAnchor.constraint(equalTo: appIcon.widthAnchor).isActive = true
        
    }
    private func setUpBlankSpace(){
        blankSpace.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor).isActive = true
        blankSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
    }
    /**
     Sets the segmented control constrains ontop of the textFieldContainer.
     */
    private func setUpSegmentedControl(){
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: textFieldsContainer.topAnchor, constant: -20).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 20)
        
    }
    /**
     Sets up the UIView textFieldContainer with the specified constraints.
     
     The UIViews constraints are:
     1) x: Equal to that of the main parents UIViews center x anchor
     2) y: Equal to that of the main parents UIViews center y anchor
     3) width: Set equal to the width of the parents UIViews width, but subtrated by a constant of -24
     4) height: A constant of 100
     */
    private func setUpTextFieldContainer(){
        textFieldsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textFieldsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        textFieldfContainerHeightAnchor = textFieldsContainer.heightAnchor.constraint(equalToConstant: 100)
        textFieldfContainerHeightAnchor?.isActive = true
        textFieldsContainer.addSubview(emailTextField)
        textFieldsContainer.addSubview(passwordTextField)
        setTextFields(textField: emailTextField, textFieldTopAnchor: textFieldsContainer.topAnchor, lineTopAnchor: emailTextField.bottomAnchor)
        // Password texField Contraints
        setTextFields(textField: passwordTextField, textFieldTopAnchor: emailTextField.bottomAnchor, lineTopAnchor: passwordTextField.bottomAnchor)
        // Setup Login/Register Button
    }
    /**
     Sets up the specified UITextField constraints based on the parameters. The left, width, and height anchor are the same for all textFields.
     The only constraint that changes is the topAnchor.
     
     - parameters:
     - textField: The UITextField that will be constrained within the textFieldContainer (UIView).
     - textFieldTopAnchor: The NSLayoutAnchor that the topAnchor of the textField will be constrained to.
     - lineTopAnchor: The NSLayout that the topAnchor of the lineSeperator (UIView) will be constrained to.
     
     */
    private func setTextFields(textField: UITextField ,textFieldTopAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, lineTopAnchor:NSLayoutYAxisAnchor ){
        textField.leftAnchor.constraint(equalTo: textFieldsContainer.leftAnchor, constant: 15).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldTopAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: textFieldsContainer.widthAnchor).isActive = true
        // if textField is equal to emailTextField or passwordTextField
        if (textField == nameTextField){
            // constant will be 1/3 since it'll only be called when the register segmented control is pressed.
            reTypedPasswordTextFieldHeightConstraint = textField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/4)
            reTypedPasswordTextFieldHeightConstraint?.isActive = true
        }
        else if(textField == emailTextField){
            emailTextFieldHeightConstraint = textField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightConstraint?.isActive = true
        }else if textField == passwordTextField {
            passwordTextFieldHeightConstraint = textField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/2)
            passwordTextFieldHeightConstraint?.isActive = true
        }else if textField == reTypedPasswordTextField {
            // constant will be 1/3 since it'll only be called when the register segmented control is pressed.
            reTypedPasswordTextFieldHeightConstraint = textField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/4)
            reTypedPasswordTextFieldHeightConstraint?.isActive = true
        }
        
        // A UIVIew will act as the line serperator for the textfields
        let line = UIView()
        textFieldsContainer.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        line.leftAnchor.constraint(equalTo: textFieldsContainer.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: lineTopAnchor).isActive = true
        line.widthAnchor.constraint(equalTo: textFieldsContainer.widthAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    /**
     A function that handles the change in height, amount of text fields, and removal and addition of targets. When the index is equal to one then we are registering a user and if its 0 we are signning in a user.
     */
    @objc private func loginOrRegister(){
        if(segmentedControl.selectedSegmentIndex == 1){
            textFieldsContainer.addSubview(nameTextField)
            textFieldsContainer.addSubview(reTypedPasswordTextField)
            textFieldfContainerHeightAnchor?.constant = 180
            setTextFields(textField: reTypedPasswordTextField, textFieldTopAnchor: passwordTextField.bottomAnchor, lineTopAnchor: reTypedPasswordTextField.bottomAnchor)
            setTextFields(textField: nameTextField, textFieldTopAnchor: reTypedPasswordTextField.bottomAnchor, lineTopAnchor: nameTextField.bottomAnchor)
            // Now to set the email and password height constaints
            emailTextFieldHeightConstraint?.isActive = false
            emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/4)
            emailTextFieldHeightConstraint?.isActive = true
            
            // We must set the height constraints back to false to be able to reset the multiplier
            passwordTextFieldHeightConstraint?.isActive = false
            passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/4)
            passwordTextFieldHeightConstraint?.isActive = true
            // Button
            loginRegisterButton.setTitle("Register", for: .normal)
            loginRegisterButton.removeTarget(self, action: #selector(login), for: .touchUpInside)
            loginRegisterButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        }else if segmentedControl.selectedSegmentIndex == 0 {
            textFieldfContainerHeightAnchor?.constant = 100
            // Re typed password
            reTypedPasswordTextField.removeFromSuperview()
            nameTextField.removeFromSuperview()
            // Email
            emailTextFieldHeightConstraint?.isActive = false
            emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightConstraint?.isActive = true
            // Password
            passwordTextFieldHeightConstraint?.isActive = false
            passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: textFieldsContainer.heightAnchor, multiplier: 1/2)
            passwordTextFieldHeightConstraint?.isActive = true
            // Button
            loginRegisterButton.setTitle("Log In", for: .normal)
            loginRegisterButton.removeTarget(self, action: #selector(register), for: .touchUpInside)
            loginRegisterButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    /**
     Sets up the LoginRegisterButton below the texftFieldContainer (UIView). LoginRegisterButton will initially
     have a target of login. When the segment control selects register it will handle the register target.
     */
    private func setUpLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: textFieldsContainer.bottomAnchor, constant: 15).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginRegisterButton.layer.cornerRadius = 12
        
        loginRegisterButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
    }
    
    
    
    @objc private func login(){
        let emailString = emailTextField.text!
        let passwordString = passwordTextField.text!
        if (!emailString.isEmpty || !passwordString.isEmpty){
            myJournalApi.login(email: emailString.lowercased(), password: passwordString, loginViewController: self)
        }else{
            print("Fill in the required text fields")
        }
        
    }
    
    @objc private func printCookies(){
        myJournalApi.signInStatus(loginViewController: self)
    }
    
    @objc private func register(){
        let emailString = emailTextField.text!
        let passwordString = passwordTextField.text!
        let secondPasswordString = reTypedPasswordTextField.text!
        let nameString = nameTextField.text!
        if (!emailString.isEmpty || !passwordString.isEmpty || !secondPasswordString.isEmpty || !nameString.isEmpty){
            if passwordString == secondPasswordString{
                myJournalApi.register(email: emailString.lowercased(), password: passwordString, name: nameString, loginViewController: self)
            }else{
                print("Passwords do not matchS")
            }
            
        }else{
            print("Fill in the required text fields")
        }
    }
    
    
   
    
    

    

}
