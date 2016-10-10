//
//  AttributedLabeled.swift
//  RSS
//
//  Created by rgonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData

@objc(AttributedLabeled)
class AttributedLabeled: NSManagedObject {

    struct Keys {
        static let Label = "label"
        static let Attributes = "attributes"
    }

    
    override func setValues(json : NSDictionary?) {
        self.label = json?[Keys.Label] as? String
        self.attributes = json?[Keys.Attributes] as? [String:String]
    }
}