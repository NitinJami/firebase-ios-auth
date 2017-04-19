//
//  UsersViewModel.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/7/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation

class UsersViewModel {
    
    let fullname: String
    let model: User
    
    init(with user: User) {
        self.fullname = user.fullname
        self.model = user
    }
}
