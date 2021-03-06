//
//  UIImageView+loadFromURL.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 05.03.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage: UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })
                
            }).resume()
        }
        
    }
}
