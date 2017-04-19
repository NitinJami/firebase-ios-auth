//
//  UsersViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/7/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import FirebaseAuth

enum RolesSection: Int {
    case Vendor, Driver, Customer, Count
    
    static var count = {
        return RolesSection.Count.rawValue
    }
    
    static let sectionTitles = [
        Vendor : "List Of Vendors",
        Driver : "List Of Drivers",
        Customer : "List Of Customers"
    ]
    
    func sectionTitle() -> String {
        if let sectionTitle = RolesSection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
}

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileNetworkDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let network = UsersNetworkService()
    var dataSource = [UsersViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        network.delegate = self
        network.getAllVendorsFromFirebase()
    }
    
    // MARK :- Button Handlers
    
    @IBAction func LogoutHandler(_ sender: UIButton) {
        try! FIRAuth.auth()?.signOut()
        self.performSegue(withIdentifier: "segueUsersVCToLoginVC", sender: self)

    }
    
    // MARK :- UITableViewDataSource Protocol Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RolesSection.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = RolesSection(rawValue: section) else { return 1 }
        
        // TODO
        switch section {
        case .Vendor: return dataSource.count
        case .Driver: return 1
        case .Customer: return 3
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = RolesSection(rawValue: section) else { return "" }
        return section.sectionTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = RolesSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        // TODO
        switch section {
        case .Vendor: return cellForVendorSection(ForRowAt: indexPath)
        case .Driver: return UITableViewCell()
        case .Customer: return UITableViewCell()
        default: return UITableViewCell()
        }
    }
    
    // MARK :- TableViewCell Helper Methods
    
    func cellForVendorSection(ForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Basic Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].fullname
        return cell
    }
    
    // MARK :- NetworkDelegate Protocol Methods
    
    func didFinishNetworkCall() {
        dataSource = network.userVMs
        tableView.reloadData()
    }
    
}
