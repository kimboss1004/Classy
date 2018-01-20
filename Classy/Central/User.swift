//
//  User.swift
//  Classy
//
//  Created by admin on 1/18/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import Foundation
import Firebase

struct User{
    let userKey: String?
    let name: String?
    let major: String?
    let grade: String?
    let credentials: String?
    let profileURL: String?
    let userRef: DatabaseReference?
    
    init(name:String, major:String, grade:String, credentials:String){
        self.userKey = (Auth.auth().currentUser?.uid)!
        self.name = name
        self.major = major
        self.grade = grade
        self.credentials = credentials
        self.profileURL = ""
        userRef = nil
    }
    
    init(snapshot:DataSnapshot){
        userRef = snapshot.ref
        if let userKey = (snapshot.value as? NSDictionary)?["userKey"] as? String {
            self.userKey = userKey
        }else{
            userKey = ""
        }
        if let name = (snapshot.value as? NSDictionary)?["name"] as? String {
            self.name = name
        }else{
            name = ""
        }
        if let major = (snapshot.value as? NSDictionary)?["major"] as? String {
            self.major = major
        }else{
            major = ""
        }
        if let grade = (snapshot.value as? NSDictionary)?["grade"] as? String{
            self.grade = grade
        }else{
            grade = ""
        }
        if let credentials = (snapshot.value as? NSDictionary)?["credentials"] as? String {
            self.credentials = credentials
        }else{
            credentials = ""
        }
        if let profileURL = (snapshot.value as? NSDictionary)?[profileURLdb] as? String {
            self.profileURL = profileURL
        } else {
            profileURL = ""
        }
    }
    
    func toAnyObject() -> AnyObject {
        return ["name" : name, "major" : major, "grade" : grade, "credentials" : credentials, profileURLdb : profileURL] as AnyObject
    }
}
