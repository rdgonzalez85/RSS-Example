//
//  BaseService.swift
//  RSS
//
//  Created by rgonzalez on 9/27/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import UIKit

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

class BaseService: NSObject {
    var baseURL = ""
    
    
    func get(onCompletition: ServiceResponse) {
        
        guard let url = NSURL(string: baseURL) else {
            return
        }
        
        let request = NSURLRequest(URL: url)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        session.dataTaskWithRequest(request) { (data, response, error) in
            do {
                guard let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] where data != nil else {
                    print("no data")
                    onCompletition(nil, error)
                    return
                }
                onCompletition(dictionary, error)
            } catch {
                print(error)
            }
            }.resume()
    }
}
