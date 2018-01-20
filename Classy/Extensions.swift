//
//  Extensions.swift
//  Classy
//
//  Created by admin on 1/19/18.
//  Copyright © 2018 kimboss. All rights reserved.
//

import Foundation
import UIKit

// this cache will hold all the images loaded, so they don't have to be reloaded from FirebaseStorage
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(urlString: String){
        // check cache first for url, if so, use image in cache
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject){
            self.image = cachedImage as? UIImage
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                // download hit an error so lets return out
                if error != nil {
                    print(error as Any)
                    return
                }
                //fire off a new download
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data!){
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}
