//
//  LoginViewController.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 3/5/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, LoginViewControllerViewModelDelegate {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.appTitle.text = "Firebase Auth Testing"
        loginViewModel.delegate = self
        
        // conform to textfield delegate methods
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
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
        self.performSegue(withIdentifier: "signin", sender: self)
    }
    
    func showAlertOnError(description: String) {
        // show alert popup
        let alert = UIAlertController(title: "Error!", message: description, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - TextField Delegate Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            loginViewModel.validateTextFields(textValue: textField.text!, fieldType: "uname")
        case passwordTextField:
            loginViewModel.validateTextFields(textValue: textField.text!, fieldType: "pword")
        default:
            showAlertOnError(description: "textFieldDidEndEditing -- Invalid text field.")
        }
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
