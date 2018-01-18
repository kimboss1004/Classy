//
//  LoginViewController.swift
//  Classy
//
//  Created by admin on 1/17/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if(error == nil){
                Helper.shared.showOKAlert(title: "Success", message: "You have logged in!", viewController: self)
                Helper.shared.switchStoryboard(storyBoardName: "Main", identifier: "home")
                return
            }
            Helper.shared.showOKAlert(title: "Error", message: (error?.localizedDescription)!, viewController: self)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
