//
//  Balance.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/18/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import ObjectMapper

class Balance: Mappable {
    var currentBalance = 0 //Positive implies money owed to Vendor; Negative implies Vendor owes money to Customers
    var userId: String!
    var userFirstName: String!
    var userLastName: String!
    
    init(currentBalance: Int, userId: String, userFN: String, userLN: String) {
        self.currentBalance = currentBalance
        self.userId = userId
        self.userFirstName = userFN
        self.userLastName = userLN
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.currentBalance <- map["CurrentBalance"]
        self.userLastName <- map["UserLastName"]
        self.userFirstName <- map["UserFirstName"]
    }
    
    func updateBalance(newTxnAmt: Int) {
        self.currentBalance += newTxnAmt
    }
}
