//
//  BalanceService.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/18/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

class BalanceNetworker {
    
    static var REF_BALANCES = FIRDatabase.database().reference().child("Balances")
    
    static func getBalancePerUser(userId: String, userFN: String = "", userLN: String = "", completed: @escaping (BalanceVM)->()) {
        REF_BALANCES.child(userId).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                let balanceObj: Balance = Mapper<Balance>().map(JSON: snapshot.value as! [String: Any])!
                let balanceVM = BalanceVM(balance: balanceObj)
                balanceVM.model.userId = snapshot.key
                completed(balanceVM)
            } else {
                let balanceVM = BalanceVM(userId: userId, userFN: userFN, userLN: userLN)
                completed(balanceVM)
            }
        })
    }
    
    func writeToDB(model: Balance) {
        let balanceJSON = Mapper().toJSON(model)
        BalanceNetworker.REF_BALANCES.child(model.userId).observeSingleEvent(of: .value, with: { balanceSS in
            if balanceSS.exists() {
                BalanceNetworker.REF_BALANCES.child(model.userId).updateChildValues(balanceJSON)
            } else {
                BalanceNetworker.REF_BALANCES.updateChildValues([model.userId: balanceJSON] as [String:Any])
            }
        })
    }
}
