//
//  ViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        
        
            guard let username = username.text,
                let password = password.text,
                !username.isEmpty && !password.isEmpty else {
                    self.errorStatus.text = "Please fill out all the fields to Sign In!"
                    self.errorStatus.textColor = UIColor.red
                    self.errorStatus.isHidden = false
                    return
            }
            FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (user, error) in
                if error != nil {
                    self.errorStatus.text = error?.localizedDescription
                    self.errorStatus.textColor = UIColor.red
                    self.errorStatus.isHidden = false
                }
            })
        
        if FIRAuth.auth()?.currentUser != nil {
             self.performSegue(withIdentifier: "SuccessSignIn", sender: self)
        }
    }
    
    @IBAction func handleCreateAccount(_ sender: UIButton) {
        
        /*guard let username = username.text,
              let password = password.text,
              let name = name.text,
              let phone = phone.text,
              !username.isEmpty && !password.isEmpty && !name.isEmpty && !phone.isEmpty else {
                self.errorStatus.text = "Please fill out all the fields for account registration!"
                self.errorStatus.textColor = UIColor.red
                self.errorStatus.isHidden = false
                return
        }
        
        FIRAuth.auth()?.createUser(withEmail: username, password: password, completion: { (user, error) in
            if error != nil {
                self.errorStatus.text = error?.localizedDescription
                self.errorStatus.textColor = UIColor.red
                self.errorStatus.isHidden = false
            } else {
                USER_REF.child((user?.uid)!).setValue(["email": username, "fullname": name, "phone": phone, "provider": user?.providerID])
                self.errorStatus.text = "Tq for Signing Up!, \(name)"
                self.errorStatus.textColor = UIColor.green
                self.errorStatus.isHidden = false
            }
        })*/
    }
    
    @IBAction func handleCurrentUser(_ sender: UIButton) {
        print(FIRAuth.auth()?.currentUser)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene = segue.destination as! UserDataController
        nextScene.currentUser = FIRAuth.auth()?.currentUser
    }
}

