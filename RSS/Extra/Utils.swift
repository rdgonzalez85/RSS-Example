//
//  Utils.swift
//  RSS
//
//  Created by rgonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

class Utils: NSObject {
    class var managedContext: NSManagedObjectContext {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        return appDelegate.managedObjectContext
    }
}

//MARK: Core data
extension Utils {
    class func removeStoredItems() {
        Utils.removeStoredEntity("Feed")
    }
    
    private class func removeStoredEntity(entity: String) {
        if #available(iOS 9.0, *) {
            let fetchRequest = NSFetchRequest(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                let appDelegate =
                    UIApplication.sharedApplication().delegate as! AppDelegate
                
                try appDelegate.persistentStoreCoordinator.executeRequest(deleteRequest, withContext: appDelegate.managedObjectContext)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }  else {
            // Fallback on earlier versions
            let fetchRequest = NSFetchRequest(entityName: entity)
            
            do {
                if let results = try Utils.managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                    for result : NSManagedObject in results {
                        Utils.managedContext.deleteObject(result)
                    }
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
    }
}

// getItem
extension NSManagedObject {
    
    struct EntityKey {
        static let Id = "Id"
        static let Feed = "Feed"
        static let Category = "Category"
        static let Artist = "Artist"
        static let Image = "Image"
        static let Price = "Price"
        static let Link = "Link"
    }
    
    class func getSavedItems(entity: String) -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: entity)
        
        do {
            let results = try Utils.managedContext.executeFetchRequest(fetchRequest)
            let items = results
            return items
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return []
    }

    class func getItems(json : NSArray?, entity: String) -> [AnyObject] {
        
        var items = [AnyObject]()
        
        for jsonFeed in json! {
            print("\(jsonFeed)")
            
            guard let currentItem = jsonFeed as? NSDictionary else {
                break
            }
            items.append(NSManagedObject.getItem(currentItem, entity: entity) )
        }
        
        do {
            try Utils.managedContext.save()
            return items
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return items
    }
    
    class func getItem(json : NSDictionary, entity: String) -> AnyObject {
        
        let item = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: Utils.managedContext)
        
        item.setValues(json)
        
        return item
    }
    
    
    func setValues(json: NSDictionary) {
        // to be overriden
        preconditionFailure("This method must be overridden")
    }

}

extension UIImageView {
    func loadImageFromURL(stringURL: String) {
        guard let url = NSURL(string: stringURL) else {
            return
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url)
            dispatch_async(dispatch_get_main_queue(), {
                if let imageData = data {
                    self.image = UIImage(data: imageData)
                }
            })
        }
    }
}
public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}