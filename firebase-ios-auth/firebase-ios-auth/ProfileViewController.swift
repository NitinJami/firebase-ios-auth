//
//  ProfileViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/6/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import FirebaseAuth


enum ProfileSection: Int {
    case Greeting, BasicInfo, Count
    
    static var count = {
        return ProfileSection.Count.rawValue
    }
    
    static let sectionTitles = [
        Greeting: "Greeting",
        BasicInfo: "BasicInfo"
    ]
    
    func sectionTitle() -> String {
        if let sectionTitle = ProfileSection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
}


class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProfileNetworkDelegate {
    
    var profileViewModel = ProfileViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.profileViewModel.delegate = self
    }
   
    @IBAction func LogOutHandler(_ sender: UIButton) {
        try! FIRAuth.auth()?.signOut()
        self.performSegue(withIdentifier: "segueProfileVCToLoginVC", sender: self)
    }
    
    // MARK :- UITableViewDataSource Protocol Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else {
            return 1
        }
        switch section {
        case .BasicInfo: return UserSection.count()//profileViewModel.numberOfRows(ForSegmentOfType: .BasicInfo)
        default: return 1 // Greeting Section will have only 1 row.
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSection(rawValue: section) else {
            return ""
        }
        return section.sectionTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .Greeting: return cellForGreetingSection(ForRowAt: indexPath)
        case .BasicInfo: return cellForBasicInfoSection(ForRowAt: indexPath)
        default: return UITableViewCell()
        }
    }
    
    // MARK :- UITableViewDataSource Protocol Helper Methods
    
    func cellForGreetingSection(ForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Greeting Cell", for: indexPath)
        cell.textLabel?.text = profileViewModel.getGreetingMessage()
        return cell
    }
    
    func cellForBasicInfoSection(ForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = UserSection(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Info Cell", for: indexPath)
        cell.textLabel?.text = section.profileTitle()
        
        switch section {
        case .FullName:
            cell.detailTextLabel?.text = profileViewModel.networkService.user?.fullname
        case .Email:
            cell.detailTextLabel?.text = profileViewModel.networkService.user?.email
        case .Address:
            cell.detailTextLabel?.text = profileViewModel.networkService.user?.address
        case .Phone:
            cell.detailTextLabel?.text = profileViewModel.networkService.user?.phone
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    // MARK :- NetworkDelegate Protocol Methods
    
    func didFinishNetworkCall() {
        self.tableView.reloadData()
    }
}
