//
//  TransactionHistoryViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 4/22/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ObjectMapper

protocol TransactionHistoryWorkerDelegate {
    func displayFetchedList()
}

class TransactionHistoryWorker {
    var transHistoryViewModels: [TransactionHistoryViewModel] = []
    var delegate: TransactionHistoryWorkerDelegate?
    
    func fetchTransactionHistory(for customerID: String) {
        let ref = FIRDatabase.database().reference().child("transaction_history_for_each_user").child(customerID)
        NetworkService.fetchItems(from: ref) { (items) in
            for (_, value) in items {
                self.transHistoryViewModels.append(TransactionHistoryViewModel(transactionHistoryModel: TransactionHistory(JSON: value)!))
            }
            self.delegate?.displayFetchedList()
        }
    }
}

struct TransactionHistory: Mappable {
    var type: String!
    var value: Int!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        type <- map["type"]
        value <- map["value"]
    }
}

struct TransactionHistoryViewModel {
    private let transactionHistoryModel: TransactionHistory
    
    init(transactionHistoryModel: TransactionHistory) {
        self.transactionHistoryModel = transactionHistoryModel
    }
    
    private let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
    
    var type: String {
        return transactionHistoryModel.type
    }
    
    var value: String {
        return currencyFormatter.string(from: NSNumber(integerLiteral: transactionHistoryModel.value))!
    }
    
}

class TransactionHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TransactionHistoryWorkerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var worker = TransactionHistoryWorker()
    var transactions: [TransactionHistoryViewModel] = []
    var customerBalance: VendorBalanceViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.worker.delegate = self
        self.worker.fetchTransactionHistory(for: customerBalance.customerID)
    }
    
    // MARK :- WorkerDelegate Protocol Method
    
    func displayFetchedList() {
        self.transactions = worker.transHistoryViewModels
        tableView.reloadData()
    }
    
    // MARK :- UITableViewDataSource Protocol Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return VendorBalanceSection.count()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = VendorBalanceSection(rawValue: section) else {
            return ""
        }
        return section.sectionTitle()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = VendorBalanceSection(rawValue: section) else {
            return 1
        }
        switch section {
        case .OverallBalance: return 3
        case .CustomerBalance: return transactions.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = VendorBalanceSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .OverallBalance: return cellForProfileSection(ForRowAt: indexPath)
        case .CustomerBalance: return cellForTransHistorySection(ForRowAt: indexPath)
        default: return UITableViewCell()
        }
    }
    
    // MARK :- UITableViewDataSource Protocol Helper Methods
    
    func cellForProfileSection(ForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Profile Picture"
        case 1:
            cell.textLabel?.text = self.customerBalance.customerName
        case 2:
            cell.textLabel?.text = self.customerBalance.balanceText
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func cellForTransHistorySection(ForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "body cell", for: indexPath)
        cell.textLabel?.text = transactions[indexPath.row].type
        cell.detailTextLabel?.text = transactions[indexPath.row].value
        return cell
    }
}
