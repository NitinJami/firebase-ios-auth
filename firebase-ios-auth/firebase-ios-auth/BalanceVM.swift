//
//  BalanceVM.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/18/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import ObjectMapper

class BalanceVM {
    
    var networker = BalanceNetworker()
    
    var model: Balance!
    var userId: String {
        return self.model.userId
    }
    var currentBalance: String { //Logic to check if current loggedin user is Vendor or Client and return the appropriate prepended "owes/owed" string
        return "$" + "\(self.model.currentBalance)"
    }
    var userName: String {
        return self.model.userFirstName + ", " + self.model.userLastName
    }
    
    ///For creating instances after fetching underlying model from network
    init(balance: Balance) {
        self.model = balance
    }
    
    ///For instantiating with Zero currentBalance. E.g. from UI or when network did not fetch a preexisting balance
    init(userId: String, userFN: String, userLN: String) {
        self.model = Balance(currentBalance: 0, userId: userId, userFN: userFN, userLN: userLN)
        self.networker = BalanceNetworker()
    }
    
    func writeToDB() {
        self.networker.writeToDB(model: self.model)
    }
    
    func updateBalance(newDeltaQty: String) {
        let newQty = Int(String(newDeltaQty.characters.dropFirst()))
        self.model.updateBalance(newTxnAmt: newQty!)
    }
    
}
