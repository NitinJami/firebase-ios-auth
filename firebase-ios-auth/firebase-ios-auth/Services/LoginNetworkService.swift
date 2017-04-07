//
//  File.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseAuth


protocol LoginNetworkDelegate {
    func didFinishNetworkCall()
}

class LoginNetworkService {
    
    var delegate: LoginNetworkDelegate?
    var error: Error?
    
    var signInCompletionHandler: (FIRUser?, Error?) -> () { return
        { (user, error) in
            if error != nil {
                self.error = error
            }
            self.delegate?.didFinishNetworkCall()
        }
    }
    
    func signInViaFirebase(withEmail username: String, andPassword password: String) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: signInCompletionHandler)
    }
}
