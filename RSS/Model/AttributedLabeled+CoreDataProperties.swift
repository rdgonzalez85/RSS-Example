//
//  AttributedLabeled+CoreDataProperties.swift
//  RSS
//
//  Created by rgonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AttributedLabeled {

    @NSManaged var attributes: [String:String]?
    @NSManaged var label: String?

}
