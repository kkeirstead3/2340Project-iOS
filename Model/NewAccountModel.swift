//
//  NewAccountModel.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/26/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class NewAccountModel: NSObject {

    /**
     * Gets the Enum value for the selected value in the PickerView
     */
    func getCategory(selectedCategory: String!) -> Category.UserTypes? {
        var tempCategory: Category.UserTypes?
        
        tempCategory = Category.UserTypes(rawValue: selectedCategory)
        
        return tempCategory
    }
    
    /**
     * Checks to make sure the email entered is not already in the system; if it is taken, will return false; otherwise, will return true
     */
    func validateEmail(newUser: User) -> Bool {
        var users: Array<User>! = []
        if let data = UserDefaults.standard.data(forKey: "Users") {
            users = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<User>
        }
        
        var validEmail: Bool = true
        
        for user in users {
            if user.email.lowercased() == newUser.email.lowercased() {
                validEmail = false
            }
        }
        
        if validEmail {
            users.append(newUser)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: users)
            UserDefaults.standard.set(encodedData, forKey: "Users")
        }
        
        return validEmail
    }
}
