//
//  RegisterViewController.swift
//  Classy
//
//  Created by admin on 1/16/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            Helper.shared.showOKAlert(title: "Invalid Input", message: "User input incorrect", viewController: self)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if(error == nil){
                Helper.shared.showOKAlert(title: "Welcome!", message: "You have succesfully registered." , viewController: self)
                Helper.shared.switchStoryboard(storyBoardName: "Main", identifier: "home")
                return
            }
            Helper.shared.showOKAlert(title: "Error", message: (error?.localizedDescription)! , viewController: self)
        }
    }
    

    
}
