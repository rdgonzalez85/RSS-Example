//
//  Link.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Link: NSManagedObject {

    struct Keys {
        static let Rel = "rel"
        static let Href = "href"
        static let TypeLink = "type"
        static let Attributes = "attributes"
    }
    
    override func setValues(json : NSDictionary?) {
        
        guard let attributesJson = json?[Keys.Attributes] as? NSDictionary else {
            return
        }
        
        if let hrefJson = attributesJson[Keys.Href] as? String {
            href = hrefJson
        }
        
        if let relJson = attributesJson[Keys.Rel] as? String {
            rel = relJson
        }
        
        if let typeJson = attributesJson[Keys.TypeLink] as? String {
            type = typeJson
        }
        
    }
}
