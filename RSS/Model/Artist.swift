//
//  Artist.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Artist: NSManagedObject {
    
    struct Keys {
        static let Href = "href"
        static let Label = "label"
        static let Attributes = "attributes"
    
    }
    
    override func setValues(json : NSDictionary?) {
        
        if let labelJson = json?[Keys.Label] as? String {
            label = labelJson
        }
        
        guard let attributesJson = json?[Keys.Attributes] else {
            return
        }
        
        if let hrefJson = attributesJson[Keys.Href] as? String {
            href = hrefJson
        }
        
    }
}
