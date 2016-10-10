//
//  Category.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Category: NSManagedObject {

    struct Keys {
        static let Scheme = "scheme"
        static let Id = "im:id"
        static let Label = "label"
        static let Term = "term"
        static let Attributes = "attributes"
        
    }
    
    override func setValues(json : NSDictionary?) {
        
        guard let attributesJson = json?[Keys.Attributes] as? NSDictionary else {
            return
        }
        
        if let labelJson = attributesJson[Keys.Label] as? String {
            label = labelJson
        }
        
        if let schemeJson = attributesJson[Keys.Scheme] as? String {
            scheme = schemeJson
        }
        
        if let idJson = attributesJson[Keys.Id] as? String {
            id = idJson
        }
        
        if let termJson = attributesJson[Keys.Term] as? String {
            term = termJson
        }
    }
}
