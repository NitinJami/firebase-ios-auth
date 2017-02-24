//
//  UserDataController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserDataController: UIViewController {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var userData: UILabel!
    var currentUser: FIRUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        USER_REF.child((currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.childSnapshot(forPath: "fullname").value as! String
            self.greeting.text = "Hello, \(value)"
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSignOut(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "SuccessSignOut", sender: self)
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    @IBAction func handleUser1Data(_ sender: UIButton) {
        USER_REF.child("fPwpGkIUV7RV5AmrNzzwLwmBqlD2").observeSingleEvent(of: .value, with: { (snapshot) in
            self.userData.text = (snapshot.childSnapshot(forPath: "phone").value as! String)
        })
    }
    
    @IBAction func handleUser2Data(_ sender: UIButton) {
        USER_REF.child("j0UjaI0VK8SoGB0TnVD8fdbWykl1").observeSingleEvent(of: .value, with: { (snapshot) in
            self.userData.text = (snapshot.childSnapshot(forPath: "phone").value as! String)
        })
    }
    
    @IBAction func handlerUser3Data(_ sender: UIButton) {
        USER_REF.child("DInZW9vFBkO5XIFox6TcaWb0qb42").observeSingleEvent(of: .value, with: { (snapshot) in
            self.userData.text = (snapshot.childSnapshot(forPath: "phone").value as! String)
        })
    }
    
    
}
