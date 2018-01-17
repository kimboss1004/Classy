//
//  Helper.swift
//  Classy
//
//  Created by admin on 1/16/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import Foundation
import UIKit

public class Helper {
    
    static let shared = Helper()
    
    func switchStoryboard(storyBoardName: String, identifier: String){
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
    }
    
    func showOKAlert(title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    
}
