//
//  ImageHelper.swift
//  NetworkingSample
//
//  Created by Rahul Mohan on 05/03/18.
//  Copyright © 2018 Rahul Mohan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    public func loadImageFromUrl(urlString: String){
        let url = URL(string:urlString)
        let task = URLSession.shared.downloadTask(with: url!, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            if error != nil{
                return
            }
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
           
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.image = image
                }
            }
        })
        task.resume()
    }
    
}
