//
//  AccountViewController.swift
//  Classy
//
//  Created by admin on 1/17/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (action) in
            do{
                try Auth.auth().signOut()
            } catch let error as NSError{
                print(error.localizedDescription)
            }
            Helper.shared.switchStoryboard(storyBoardName: "Register", identifier: "login")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)

    }
    

}
