//
//  Price.swift
//  RSS
//
//  Created by rgonzalez on 10/6/16.
//  Copyright © 2016 rgonzalez. All rights reserved.
//

import Foundation
import CoreData


class Price: NSManagedObject {

    struct Keys {
        static let Currency = "currency"
        static let Amount = "amount"
        static let Attributes = "attributes"
        static let Label = "label"

    }
    
    func price() -> String {
        if let amount = self.amount {
            let amountFloat = Float(amount)
            
            if amountFloat > 0 {
                return amount
            } else {
                return "Free"
            }
        }
        
        return "Free"
    }
    
    override func setValues(json : NSDictionary?) {
        if let labelJson = json?[Keys.Label] as? String {
            label = labelJson
        }
        
        guard let attributesJson = json?[Keys.Attributes] as? NSDictionary else {
            return
        }
        
        if let amountJson = attributesJson[Keys.Amount] as? String {
            amount = amountJson
        }
        
        if let currencyJson = attributesJson[Keys.Currency] as? String {
            currency = currencyJson
        }
    }
}
