//
//  Id.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Id: NSManagedObject {

    
    struct Keys {
        static let BundleId = "im:bundleId"
        static let Id = "im:id"
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
        
        if let bundleIdJson = attributesJson[Keys.BundleId] as? String {
            bundleId = bundleIdJson
        }
        
        if let idJson = attributesJson[Keys.Id] as? String {
            id = idJson
        }

    }
}
