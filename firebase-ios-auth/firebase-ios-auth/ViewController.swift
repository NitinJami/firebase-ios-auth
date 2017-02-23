//
//  ViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AppName: UILabel!
    @IBOutlet weak var errorStatus: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.AppName.text = "Firebase iOS Testing"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleSignIn(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "SuccessSignIn", sender: self)
    }
    
    @IBAction func handleCreateAccount(_ sender: UIButton) {
    }
    
}

