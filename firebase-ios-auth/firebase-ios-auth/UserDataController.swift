//
//  UserDataController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit

class UserDataController: UIViewController {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var userData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSignOut(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SuccessSignOut", sender: self)
    }
}
