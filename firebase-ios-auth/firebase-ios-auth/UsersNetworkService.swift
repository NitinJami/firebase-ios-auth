//
//  UsersNetworkService.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/7/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

class UsersNetworkService {
    var delegate: ProfileNetworkDelegate?
    var userVMs: [UsersViewModel] = [UsersViewModel]()
    
    var completionHandler: (FIRDataSnapshot) -> Void { return
        { (snapshot) in
            for eachSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let snap = eachSnapshot.value {
                    self.userVMs.append(UsersViewModel(with: User(JSON: snap as! [String:String])!))
                }
            }
            self.delegate?.didFinishNetworkCall()
        }
    }
    
    var errorHandler: ((Error) -> Void)? { return
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getAllVendorsFromFirebase() {
        let VENDOR_REF = FIRDatabase.database().reference().child("users").child("vendors")
        VENDOR_REF.observeSingleEvent(of: .value, with: completionHandler, withCancel: errorHandler)
    }
}
