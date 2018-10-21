//
//  Location.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/5/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class Location: NSObject, NSCoding {

    let key, name, latitude, longitude, streetAddress, city, state, zip, type, phone, website: String
    let attributes: [String]
    var donations: [DonationItem]
    
    /**
     * Constructor for the location with no donation items
     */
    init(key: String, name: String, latitude: String, longitude: String, streetAddress: String, city: String, state: String, zip: String, type: String, phone: String, website: String) {
        self.key = key
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.type = type
        self.phone = phone
        self.website = website
        self.attributes = [key, name, latitude, longitude, streetAddress, city, state, zip, type, phone, website]
        self.donations = []
    }
    
    /**
     * Constructor for the location with its donation items
     */
    init(key: String, name: String, latitude: String, longitude: String, streetAddress: String, city: String, state: String, zip: String, type: String, phone: String, website: String, donations: [DonationItem]) {
        self.key = key
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.type = type
        self.phone = phone
        self.website = website
        self.attributes = [key, name, latitude, longitude, streetAddress, city, state, zip, type, phone, website]
        self.donations = donations
    }

    /**
     * Since Location is a custom object, decoder constructs it from its components
     */
    required convenience init(coder aDecoder: NSCoder) {
        let decodedKey = aDecoder.decodeObject(forKey: "Key") as! String
        let decodedName = aDecoder.decodeObject(forKey: "Name") as! String
        let decodedLatitude = aDecoder.decodeObject(forKey: "Latitude") as! String
        let decodedLongitude = aDecoder.decodeObject(forKey: "Longitude") as! String
        let decodedStreetAddress = aDecoder.decodeObject(forKey: "Street Address") as! String
        let decodedCity = aDecoder.decodeObject(forKey: "City") as! String
        let decodedState = aDecoder.decodeObject(forKey: "State") as! String
        let decodedZip = aDecoder.decodeObject(forKey: "Zip") as! String
        let decodedType = aDecoder.decodeObject(forKey: "Type") as! String
        let decodedPhone = aDecoder.decodeObject(forKey: "Phone") as! String
        let decodedWebsite = aDecoder.decodeObject(forKey: "Website") as! String
        let decodedDonations = aDecoder.decodeObject(forKey: "Donations") as! [DonationItem]

        self.init(key: decodedKey, name: decodedName, latitude: decodedLatitude, longitude: decodedLongitude, streetAddress: decodedStreetAddress, city: decodedCity, state: decodedState, zip: decodedZip, type: decodedType, phone: decodedPhone, website: decodedWebsite, donations: decodedDonations)
    }
    
    /**
     * Since Location is a custom object, encoder separates it down into its components
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "Key")
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(latitude, forKey: "Latitude")
        aCoder.encode(longitude, forKey: "Longitude")
        aCoder.encode(streetAddress, forKey: "Street Address")
        aCoder.encode(city, forKey: "City")
        aCoder.encode(state, forKey: "State")
        aCoder.encode(zip, forKey: "Zip")
        aCoder.encode(type, forKey: "Type")
        aCoder.encode(phone, forKey: "Phone")
        aCoder.encode(website, forKey: "Website")
        aCoder.encode(donations, forKey: "Donations")
    }
    
    /**
     * Returns all donation items in the specified category for the current location
     */
    func getItemsForCategory(category: String) -> [DonationItem]
    {
        var toReturn: [DonationItem] = []
        for donation in donations {
            if donation.category.contains(category) {
                toReturn.append(donation)
            }
        }
        
        return toReturn
    }
    
    /**
     * Returns all donation items containing the specified name for the current location
     */
    func getItemsForName(name: String) -> [DonationItem]
    {
        var toReturn: [DonationItem] = []
        for donation in donations {
            if donation.shortDescription.lowercased().contains(name.lowercased()) {
                toReturn.append(donation)
            }
        }
        
        return toReturn
    }
}
