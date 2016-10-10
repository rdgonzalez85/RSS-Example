//
//  Feed+CoreDataProperties.swift
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

extension Feed {

    @NSManaged var name: String?
    @NSManaged var rights: String?
    @NSManaged var summary: String?
    @NSManaged var title: String?
    @NSManaged var artist: Artist?
    @NSManaged var category: Category?
    @NSManaged var contentType: AttributedLabeled?
    @NSManaged var id: Id?
    @NSManaged var image: NSSet?
    @NSManaged var link: Link?
    @NSManaged var price: Price?
    @NSManaged var releaseDate: AttributedLabeled?

}
