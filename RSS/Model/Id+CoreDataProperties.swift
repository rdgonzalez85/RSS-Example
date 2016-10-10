//
//  Id+CoreDataProperties.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Id {

    @NSManaged var bundleId: String?
    @NSManaged var id: String?
    @NSManaged var label: String?

}
