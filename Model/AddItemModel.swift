//
//  AddItemModel.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/14/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class AddItemModel: NSObject {

    /**
     * Returns a tuple with each category paired with a boolean value (to be used to dictate whether that particular category has been selected or not)
     */
    func getCategories() -> [(String, Bool)] {
        var categories: [String] = []
        if let data = UserDefaults.standard.data(forKey: "Categories") {
            categories = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String]
        }
        
        var toReturn: [(String, Bool)] = []
        
        for cat in categories {
            toReturn.append((cat, false))
        }
        
        return toReturn
    }
    
    /**
     * Takes the tuple and looks at the boolean value for each entry; if the boolean value is true, then the category has been selected, and will be included in the returned array
     */
    func getChosenCategories(categories: [(String, Bool)]) -> [String] {
        var toReturn: [String] = []
        for cat in categories {
            if cat.1 == true {
                toReturn.append(cat.0)
            }
        }
        return toReturn
    }
}
