//
//  ProfileNetworkService.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/5/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

protocol ProfileNetworkDelegate {
    func didFinishNetworkCall()
}

class ProfileNetworkService {
    
    private let USER_REF = FIRDatabase.database().reference().child("users/eaters").child((SessionManager.shared.currentUser?.uid)!)
    var delegate: ProfileNetworkDelegate?
    var user: User?
    
    var completionHandler: (FIRDataSnapshot) -> Void { return
        { (snapshot) in
            if let snap = snapshot.value {
                self.user = User(JSON: snap as! [String:String])
            }
            self.delegate?.didFinishNetworkCall()
        }
    }
    
    var errorHandler: ((Error) -> Void)? { return
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func fetchViaFirebase() {
        USER_REF.observeSingleEvent(of: .value, with: completionHandler, withCancel: errorHandler)
    }
    
}
