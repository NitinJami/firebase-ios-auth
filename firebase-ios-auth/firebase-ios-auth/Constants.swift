//
//  Constants.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseDatabase

let BASE_REF = FIRDatabase.database().reference()
let USER_REF = BASE_REF.child("Users")
