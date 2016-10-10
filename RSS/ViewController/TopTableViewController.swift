//
//  TopTableViewController.swift
//  RSS
//
//  Created by Rodrigo Gonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import UIKit

class TopTableViewController: UITableViewController {

    
    var feedItems = [Feed]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        makeRequest()
    }

    func makeRequest() {
        let service = FeedService()
        service.getFeed { (feeds, error) in
                dispatch_async(dispatch_get_main_queue(),{
                    if feeds?.count > 0 {
                        self.feedItems = feeds!
                    }
                })
        }
    }
    
    let cellIdentifier = "topTableViewCell"
}

// MARK: - Table view data source

extension TopTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return feedItems.count > 0 ? 1 : 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopTableViewCell
        
        cell.setData(feedItems[indexPath.row], position: indexPath.row + 1)
        
        return cell
    }
}
