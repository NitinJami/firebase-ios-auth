//
//  User.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/1/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseAuth
import ObjectMapper

enum UserSection: Int {
    case FullName, Email, Address, Phone, Count
    
    static var count = {
        return UserSection.Count.rawValue
    }
    
    static let profileTitles = [
        FullName: "Full Name: ",
        Email: "Email: ",
        Address: "Address: ",
        Phone: "Phone: "
    ]
    
    func profileTitle() -> String {
        if let profileTitle = UserSection.profileTitles[self] {
            return profileTitle
        } else {
            return ""
        }
    }
}

class User: Mappable {
    var fullname: String
    var email: String
    var address: String
    var phone: String
    
    required init?(map: Map) {
        self.fullname = ""
        self.address = ""
        self.email = ""
        self.phone = ""
        if map.JSON["fullname"] as! String == "", map.JSON["email"] as! String == "", map.JSON["address"] as! String == "", map.JSON["phone"] as! String == "" {
            return nil
        }
    }
    
    func mapping(map: Map) {
        fullname <- map["fullname"]
        email <- map["email"]
        address <- map["address"]
        phone <- map["phone"]
    }
}

class SessionManager {
    static let shared = SessionManager(currentUser: FIRAuth.auth()?.currentUser)
    let currentUser: FIRUser?
    private init (currentUser: FIRUser?) {
        self.currentUser = currentUser
    }
}
