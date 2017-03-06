//
//  UserViewModel.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/1/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation

protocol LoginViewControllerViewModel {
    
    var delegate: LoginViewControllerViewModelDelegate { get set }
    
    func signinButtonPressed()
}

// ViewModel should not talk to ViewController directly. 
// It should only update notifiations via it's delegate.
// ViewController owns ViewModel.

protocol LoginViewControllerViewModelDelegate {
    func showAlertOnError()
    func moveToProfileView()
}

class LoginViewModel: LoginViewControllerViewModel {
    
    internal var delegate: LoginViewControllerViewModelDelegate
    private var usernameTextValue: String = ""
    private var passwordTextValue: String = ""
        
    func signinButtonPressed() {
        // Validate Username and Password Text Fields.
        
        // firebase call to authenticate user
        
        // if success -> tell delegate to move to profile view.
        // if failure -> tell delegate to show alert with error desc.
    }
    
    func tellDelegateToMoveToProfileView() {
        delegate.moveToProfileView()
    }
    
    func tellDelegateToShowAlertOnError() {
        delegate.showAlertOnError()
    }
}
