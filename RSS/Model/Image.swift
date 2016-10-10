//
//  Image.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Image: NSManagedObject {

    struct Keys {
        static let Height = "height"
        static let Label = "label"
        static let Attributes = "attributes"
    }
    
    override func setValues(json : NSDictionary?) {
        
        if let labelJson = json?[Keys.Label] as? String {
            label = labelJson
        }
        
        guard let attributesJson = json?[Keys.Attributes] as? NSDictionary else {
            return
        }
        
        if let heightJson = attributesJson[Keys.Height] as? String {
            height = heightJson
        }
        
    }
}
