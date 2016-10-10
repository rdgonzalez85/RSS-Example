//
//  TopTableViewCell.swift
//  RSS
//
//  Created by Rodrigo Gonzalez on 10/4/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import UIKit

class TopTableViewCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var feedImageView: UIView!
    
    @IBOutlet weak var feedName: UILabel!
    @IBOutlet weak var feedCategory: UILabel!
    
    @IBOutlet weak var feedPosition: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.borderColor = UIColor.blueColor().CGColor
        buyButton.layer.cornerRadius = 10
        buyButton.layer.borderWidth = 1
        buyButton.layer.masksToBounds = true
        
        shadow()
    }

    
    private func shadow() {
        let cornerRadius: CGFloat = 8.0
        
        feedImageView.layer.shadowOffset = CGSizeMake(1, 0)
        feedImageView.layer.shadowOpacity = 0.6
        feedImageView.layer.shadowRadius = cornerRadius
        feedImageView.layer.shadowColor = UIColor.lightGrayColor().CGColor;
        feedImageView.layer.shadowPath = UIBezierPath(roundedRect: feedImageView.bounds, cornerRadius: cornerRadius).CGPath
        
        feedImage.layer.cornerRadius = cornerRadius
        feedImage.layer.masksToBounds = true
        feedImage.frame = feedImageView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedImage.image = nil
        // cancel loading
    }

    
    func setData(feed: Feed, position: Int) {
        feedName.text = feed.name
        feedCategory.text = feed.category?.term
        feedPosition.text = String(position)
        
        buyButton.setTitle(feed.price?.price(), forState: .Normal)
        
        feedImage.loadImageFromURL(feed.smallImage())
    }

}
