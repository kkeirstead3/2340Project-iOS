//
//  User.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/25/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {

    var name: String!
    var email: String!
    var password: String!
    var category: Category.UserTypes!
    
    /**
     * Constructor that assigns the user's name, email, password, and user type
     */
    init(name: String, email: String, password: String, category:Category.UserTypes) {
        self.name = name
        self.email = email
        self.password = password
        self.category = category
    }
    
    /**
     * Since User is a custom object, decoder constructs it from its components
     */
    required convenience init(coder aDecoder: NSCoder) {
        let decodedName = aDecoder.decodeObject(forKey: "Name") as! String
        let decodedEmail = aDecoder.decodeObject(forKey: "Email") as! String
        let decodedPassword = aDecoder.decodeObject(forKey: "Password") as! String
        let decodedCategoryString = aDecoder.decodeObject(forKey: "Category") as! String
        
        let convertedCat = Category.UserTypes(rawValue: decodedCategoryString)
        
        self.init(name: decodedName, email: decodedEmail, password: decodedPassword, category: convertedCat!)
    }
    
    /**
     * Since User is a custom object, encoder separates it down into its components
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(email, forKey: "Email")
        aCoder.encode(password, forKey: "Password")
        aCoder.encode(category.rawValue, forKey: "Category")
    }

}
