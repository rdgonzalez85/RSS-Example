//
//  FeedService.swift
//  RSS
//
//  Created by rgonzalez on 9/27/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import UIKit

typealias FeedResponse = ([Feed]?, NSError?) -> Void

class FeedService: BaseService {

    func getFeed(onCompletition: FeedResponse) {
        if Reachability.isConnectedToNetwork() {
            baseURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
            get { (dictionary, error) in
                Utils.removeStoredItems()
                let json = dictionary?["feed"] as? NSDictionary
                onCompletition(Feed.getItems(json?["entry"] as? NSArray, entity: Feed.entityKey) as? [Feed], error)
            }
        } else {
            onCompletition(Feed.getSavedItems(Feed.entityKey) as? [Feed], nil)
        }
    }
}
