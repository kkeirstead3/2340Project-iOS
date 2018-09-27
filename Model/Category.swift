//
//  Category.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/25/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class Category: NSObject {

    /**
     * Enum for the various user types; the string equivalencies (raw values) are set to each one
     */
    enum UserTypes: String {
        case User = "User"
        case LocationEmployee = "Location Employee"
        case Admin = "Admin"
        case Manager = "Manager"
    }
}
