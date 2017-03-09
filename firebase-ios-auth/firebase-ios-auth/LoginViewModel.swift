//
//  UserViewModel.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/1/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginViewControllerViewModel {
    var delegate: LoginViewControllerViewModelDelegate? { get set }
    func signinButtonPressed()
}

// ViewModel should not talk to ViewController directly. 
// It should only update notifiations via it's delegate.
// ViewController owns ViewModel.

protocol LoginViewControllerViewModelDelegate {
    func showAlertOnError(description: String)
    func moveToProfileView()
}

struct LoginViewModel: LoginViewControllerViewModel {
    
    internal var delegate: LoginViewControllerViewModelDelegate?
    private var usernameTextValue: String
    private var passwordTextValue: String
    private var isUsernameValid: Bool = false
    private var isPasswordValid: Bool = false
    
    private var textFieldsValid: Bool {
        return isUsernameValid && isPasswordValid
    }
    
    init() {
        self.usernameTextValue = ""
        self.passwordTextValue = ""
    }
    
    mutating func validateTextFields(textValue: String, fieldType: String) {
        // Validate username and password should not have empty strings
        switch fieldType {
            case "uname" where textValue != "": isUsernameValid = true; usernameTextValue = textValue
            case "uname" where textValue == "": isUsernameValid = false
            case "pword" where textValue != "": isPasswordValid = true; passwordTextValue = textValue
            case "pword" where textValue == "": isPasswordValid = false
            default: tellDelegateToShowAlertOnError(desc: "validateTextFields -- Improper textfield passed")
        }
    }
    
    func signinButtonPressed() {
        // Validate Username and Password Text Fields
        if textFieldsValid {
            // firebase call to authenticate user
            // if success -> tell delegate to move to profile view.
            // if failure -> tell delegate to show alert with error desc.
            FIRAuth.auth()?.signIn(withEmail: usernameTextValue, password: passwordTextValue, completion: { (user, error) in
                if error != nil {
                    self.tellDelegateToShowAlertOnError(desc: (error?.localizedDescription)!)
                } else {
                    self.tellDelegateToMoveToProfileView()
                }
            })
        } else {
            tellDelegateToShowAlertOnError(desc: "Username and/or Password fields should not be empty")
        }
    }
    
    func tellDelegateToMoveToProfileView() {
        delegate?.moveToProfileView()
    }
    
    func tellDelegateToShowAlertOnError(desc: String) {
        delegate?.showAlertOnError(description: desc)
    }
}
