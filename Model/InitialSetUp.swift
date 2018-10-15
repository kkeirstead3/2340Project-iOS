//
//  InitialSetUp.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/12/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class InitialSetUp: NSObject {

    /**
     * Handles the creation of the default categories (if they don't already exist)
     */
    func setDonationItemCategories() {
     
        var categories: [String] = []
        if let data = UserDefaults.standard.data(forKey: "Categories") {
            categories = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String]
        }
        
        if categories.count == 0 {
            // Put defaults in here
            categories = ["Clothing", "Hat", "Kitchen", "Electronics", "Household", "Other"]
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: categories)
            UserDefaults.standard.set(encodedData, forKey: "Categories")
        }
    }
}
