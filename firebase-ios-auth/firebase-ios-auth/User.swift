//
//  User.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/1/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation

protocol FullAddress {
    var firstLine: String { get }
    var secondLine: String? { get }
    var city: String { get }
    var state: String { get }
    var zipcode: String { get }
}

protocol User {
    var firstName: String { get set }
    var lastName: String { get set }
    var phone: String { get set }
    var email: String { get set }
    var welcomeMessage: String { get }
}

struct Vendor: User {
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    
    init(fname: String, lname: String, phone: String, email: String) {
        self.firstName = fname
        self.lastName = lname
        self.phone = phone
        self.email = email
    }
    
    var welcomeMessage: String {
        return "Welcome, \(self.firstName) \(self.lastName)! You are a Vendor."
    }
}

struct Driver: User {
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    
    init(fname: String, lname: String, phone: String, email: String) {
        self.firstName = fname
        self.lastName = lname
        self.phone = phone
        self.email = email
    }
    
    var welcomeMessage: String {
        return "Welcome, \(self.firstName) \(self.lastName)! You are a Driver."
    }
}
