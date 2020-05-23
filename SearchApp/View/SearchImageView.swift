//
//  SearchImageView.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/14/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class SearchImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageUrlString:String?
    
    func loadImageFromAPI(imageFromCache: NSCache<NSString, AnyObject>, urlString:String) -> URLSessionDataTask? {
        imageUrlString = urlString
        self.image = nil
        
        if let imageToCache = imageFromCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageToCache
            return nil
        }
        
        let api = APIManager.sharedInstance
        return api.doGetImage(urlString, headers: nil, completionHandler: {[weak self](data:Data?) in
            guard let self = self,let dataImage = data else {
                return
            }
            
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: dataImage)
                if let imageCache = imageToCache {
                    imageFromCache.setObject(imageCache, forKey: urlString as NSString)
                    if (self.imageUrlString == urlString) {
                        self.loadImage(urlString, imageFromCache: imageFromCache)
                    }
                }
            })
        })
        
    }
    
    private func loadImage(_ urlString: String, imageFromCache: NSCache<NSString,AnyObject>) {

        if let image = imageFromCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
        }

    }


}
