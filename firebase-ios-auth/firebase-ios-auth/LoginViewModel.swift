//
//  UserViewModel.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/1/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseAuth

// ViewModel should not talk to ViewController directly. 
// It should only update any changes via it's delegate.

protocol LoginViewModelDelegate {
    func showAlertOnError(description: String)
    func moveToProfileView()
}

class LoginViewModel: LoginNetworkDelegate {
    internal var delegate: LoginViewModelDelegate?
    private var usernameTextValue: String
    private var passwordTextValue: String
    private var isUsernameValid: Bool
    private var isPasswordValid: Bool
    
    private var networkSerivce = LoginNetworkService()
    
    private var textFieldsValid: Bool {
        return isUsernameValid && isPasswordValid
    }
    
    init() {
        self.usernameTextValue = ""
        self.passwordTextValue = ""
        self.isUsernameValid = false
        self.isPasswordValid = false
        self.networkSerivce.delegate = self
    }
    
    func validateTextFields(textValue: String, fieldType: String) {
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
        if textFieldsValid {
            networkSerivce.signInViaFirebase(withEmail: usernameTextValue, andPassword: passwordTextValue)
            // TODO: Code to start UI spinning indicator
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
    
    func didFinishNetworkCall() {
        // TODO: Code to stop UI spinning indicator
        
        if let error = self.networkSerivce.error {
            tellDelegateToShowAlertOnError(desc: error.localizedDescription)
        }
        // Sign-in Success

        tellDelegateToMoveToProfileView()
    }
}
