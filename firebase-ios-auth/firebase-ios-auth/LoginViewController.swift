//
//  LoginViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/5/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewControllerViewModelDelegate {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.appTitle.text = "Firebase Auth Testing"

        loginViewModel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSignIn(_ sender: UIButton) {
        loginViewModel.signinButtonPressed()
    }
    
    // MARK: - LoginViewModel Delegate Methods
    
    func moveToProfileView() {
        // segue to profile view
    }
    
    func showAlertOnError() {
        // show alert popup
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
