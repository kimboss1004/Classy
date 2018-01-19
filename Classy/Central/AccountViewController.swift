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

    var dbref: DatabaseReference!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var gradeTextView: UITextView!
    @IBOutlet weak var majorTextView: UITextView!
    @IBOutlet weak var credentialsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbref = Database.database().reference().child(USERdb)
        setTextFields()
    }
    
    func setTextFields(){
        let userRef = dbref.child((Auth.auth().currentUser?.uid)!)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            let user = User(snapshot: snapshot)
            self.nameTextView.text = user.name
            self.gradeTextView.text = user.grade
            self.majorTextView.text = user.major
            self.credentialsTextView.text = user.credentials
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func uploadProfile(_ sender: Any) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        let user = User(name: nameTextView.text, major: majorTextView.text, grade: gradeTextView.text, credentials: credentialsTextView.text)
        dbref.updateChildValues([user.userKey : user.toAnyObject()])
        Helper.shared.showOKAlert(title: "Saved", message: "Your profile has been saved", viewController: self)
    }
    
    
}
