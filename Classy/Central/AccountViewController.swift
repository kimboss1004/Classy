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
    var profileImageUrlText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbref = Database.database().reference().child(USERdb)
        setTextFields()
        // circular profile pic
        profileImageView.layer.cornerRadius = 90
        profileImageView.layer.masksToBounds = true
    }
    
    func setTextFields(){
        // calls current user and displays its attributes
        let userRef = dbref.child((Auth.auth().currentUser?.uid)!)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            let user = User(snapshot: snapshot)
            self.nameTextView.text = user.name
            self.gradeTextView.text = user.grade
            self.majorTextView.text = user.major
            self.credentialsTextView.text = user.credentials
            if let profileURL = user.profileURL {
                // sets value of the url field, for the update method
                self.profileImageUrlText = profileURL
                // cache image using extension
                self.profileImageView.loadImageUsingCacheWithURLString(urlString: profileURL)
            }
            
        }
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
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        // saves String attributes of user, but not profile
        let user = User(name: nameTextView.text, major: majorTextView.text, grade: gradeTextView.text, credentials: credentialsTextView.text, profileURL: profileImageUrlText)
        dbref.updateChildValues([user.userKey! : user.toAnyObject()])
        Helper.shared.showOKAlert(title: "Saved", message: "Your profile has been saved", viewController: self)
    }
    
    
}


extension AccountViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        profileImageView.image = image
        dismiss(animated: true, completion: nil)
        
        // store image in FirebaseStorage
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(profileImageView.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error as Any)
                        return
                    }
                    // save image-url in current User
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        let userId = Auth.auth().currentUser?.uid
                        self.dbref.child(userId!).child(profileURLdb).setValue(profileImageURL)
                        // set profileText to url, for save method
                        self.profileImageUrlText = profileImageURL
                        Helper.shared.showOKAlert(title: "Uploaded", message: "Your profile uploaded!", viewController: self)
                    }
            })
        }
    }
    
}
