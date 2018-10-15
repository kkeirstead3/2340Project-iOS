//
//  DonationItem.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/11/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class DonationItem: NSObject, NSCoding {

    let timeStamp: String
    let location: Location
    let shortDescription: String
    let fullDescription: String
    let comments: String
    let value: String
    let category: [String]
    
    /**
     * Constructor
     */
    init(timeStamp: String, location: Location, shortDescription: String,
         fullDescription: String, comments: String, value: String, category: [String]) {
        self.timeStamp = timeStamp
        self.location = location
        self.shortDescription = shortDescription
        self.fullDescription = fullDescription
        self.comments = comments
        self.value = value
        self.category = category
    }
    
    /**
     * Since DonationItem is a custom object, decoder constructs it from its components
     */
    required convenience init(coder aDecoder: NSCoder) {
        let decodedTimeStamp = aDecoder.decodeObject(forKey: "Time Stamp") as! String
        let decodedLocation = aDecoder.decodeObject(forKey: "Location") as! Location
        let decodedShortDescription = aDecoder.decodeObject(forKey: "Short Description") as! String
        let decodedFullDescription = aDecoder.decodeObject(forKey: "Full Description") as! String
        let decodedComments = aDecoder.decodeObject(forKey: "Comments") as! String
        let decodedValue = aDecoder.decodeObject(forKey: "Value") as! String
        let decodedCategory = aDecoder.decodeObject(forKey: "Category") as! [String]

        self.init(timeStamp: decodedTimeStamp, location: decodedLocation, shortDescription: decodedShortDescription, fullDescription: decodedFullDescription, comments: decodedComments, value: decodedValue, category: decodedCategory)
    }
    
    /**
     * Since Donation Item is a custom object, encoder separates it down into its components
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timeStamp, forKey: "Time Stamp")
        aCoder.encode(location, forKey: "Location")
        aCoder.encode(shortDescription, forKey: "Short Description")
        aCoder.encode(fullDescription, forKey: "Full Description")
        aCoder.encode(comments, forKey: "Comments")
        aCoder.encode(value, forKey: "Value")
        aCoder.encode(category, forKey: "Category")
    }

}
