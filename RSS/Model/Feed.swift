//
//  Feed.swift
//  RSS
//
//  Created by rgonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData

@objc(Feed)
class Feed: NSManagedObject {
    
    class var entityKey: String {
        return EntityKey.Feed
    }
    
    struct Keys {
        static let Artist = "im:artist"
        static let Category = "category"
        static let Title = "title"
        static let Rights = "rights"
        static let Price = "im:price"
        static let Link = "link"
        static let Id = "id"
        static let ContentType = "im:contentType"
        static let Summary = "summary"
        static let ReleaseDate = "im:releaseDate"
        static let Name = "im:name"
        static let Image = "im:image"
    }

    override func setValues(json : NSDictionary?) {
        
        if let artistJson = json?[Keys.Artist] as? NSDictionary {
            artist = Artist.getItem(artistJson, entity: EntityKey.Artist) as? Artist
        }
        
        if let categoryJson = json?[Keys.Category] as? NSDictionary {
            category = Category.getItem(categoryJson, entity: EntityKey.Category) as? Category
        }
        
        if let imageJson = json?[Keys.Image] as? NSArray {
            if let images = Image.getItems(imageJson, entity: EntityKey.Image) as? [Image] {
                image = NSSet(array: images)
            }
        }
        
        if let nameJson = json?[Keys.Name] as? NSDictionary {
            name = getLabel(nameJson)
        }
        
//        if let releaseDateJson = json?[Keys.ReleaseDate] as? NSDictionary {
//            releaseDate = AttributedLabeled.getItem(releaseDateJson)
//        }
        
        if let summaryJson = json?[Keys.Summary] as? NSDictionary {
            summary = getLabel(summaryJson)
        }
        
//        if let contentTypeJson = json?[Keys.ContentType] as? NSDictionary {
//            contentType = AttributedLabeled.getItem(contentTypeJson)
//        }
        
        if let idJson = json?[Keys.Id] as? NSDictionary {
            id = Id.getItem(idJson, entity: EntityKey.Id) as? Id
        }
        
        if let linkJson = json?[Keys.Link] as? NSDictionary {
            link = Link.getItem(linkJson, entity: EntityKey.Link) as? Link
        }
        
        if let priceJson = json?[Keys.Price] as? NSDictionary {
            price = Price.getItem(priceJson, entity: EntityKey.Price) as? Price
        }
        
        if let rightsJson = json?[Keys.Rights] as? NSDictionary {
            rights = getLabel(rightsJson)
        }
        
        if let titleJson = json?[Keys.Title] as? NSDictionary {
            title = getLabel(titleJson)
        }
    }
    
    let Label = "label"
}
// images for the feed
extension Feed {
    func smallImage() -> String {
        guard let images = image?.allObjects as? [Image] else {
            return ""
        }
        var tmpImg = images.first
        
        for img in images {
            if let tmpImgHeight = tmpImg?.height {
                if img.height?.compare(tmpImgHeight, options: NSStringCompareOptions.NumericSearch, range: nil, locale: nil) == NSComparisonResult.OrderedAscending {
                    tmpImg = img
                }
            }
        }
        
        guard let imageString = tmpImg?.label else {
            return ""
        }
        
        return imageString
    }
}
// items that have only a label
extension Feed {
    func getLabel(json: NSDictionary?) -> String? {
        return json?[Label] as? String
    }
}
