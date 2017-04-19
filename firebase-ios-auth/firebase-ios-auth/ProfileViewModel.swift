//
//  ProfileViewModel.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/6/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import Foundation
import FirebaseAuth


class ProfileViewModel: ProfileNetworkDelegate {
    
    let networkService = ProfileNetworkService()
    var delegate: ProfileNetworkDelegate?
    
    init() {
        self.networkService.delegate = self
        networkService.fetchViaFirebase()
    }
    
    func getGreetingMessage() -> String {
        if let fullname = networkService.user?.fullname {
            return "Howdy, Welcome \(fullname)"
        }
        return ""
    }
    
    func numberOfRows(ForSegmentOfType type: ProfileSection) -> Int {
        return UserSection.count()
    }
    
    func didFinishNetworkCall() {
        self.delegate?.didFinishNetworkCall()
    }
}
