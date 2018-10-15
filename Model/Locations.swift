//
//  Locations.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/5/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class Locations: NSObject {

    // Variables
    
    let fileName = "LocationData"
    let LINES_PER_ENTRY = 1
    
    /**
     * Enum for a corresponding name for each index; each value has a String description
     */
    enum SaveEquivalencies: Int {
        case Key = 0,
        Name,
        Latitude,
        Longitude,
        StreetAddress,
        City,
        State,
        Zip,
        LocationType,
        Phone,
        Website
        
        var description: String {
            switch self {
                case .Key:
                    return "Key"
                case .Name:
                    return "Name"
                case .Latitude:
                    return "Latitude"
                case .Longitude:
                    return "Longitude"
                case .StreetAddress:
                    return "Street Address"
                case .City:
                    return "City"
                case .State:
                    return "State"
                case .Zip:
                    return "Zip"
                case .LocationType:
                    return "Type"
                case .Phone:
                    return "Phone"
                case .Website:
                    return "Website"
            }
        }
    }
    
    /**
     * Reads location data from CSV file and sends it off to be parsed
     */
    func loadLocations()
    {
        let path = Bundle.main.path(forResource: fileName, ofType: "csv")
        
        do {
            var contents = try String(contentsOfFile: path!, encoding: .utf8)
            contents = contents.replacingOccurrences(of: "\r", with: "\n")
            contents = contents.replacingOccurrences(of: "\n\n", with: "\n")
            parseContents(contents: contents);
        } catch {
            print("This path did not work properly: \(path!)")
        }
    }
    
    /**
     * Parses the comma separated values and loads the locations into the UserDefaults
     */
    func parseContents(contents: String) {
        
        var locations: [String: Location] = [:]
        if let data = UserDefaults.standard.data(forKey: "Locations") {
            locations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Location] ?? [:]
        }

        var lines = contents.split(separator: "\n")
        
        lines.removeFirst()
        
        for line in lines {
            let splitLine = line.split(separator: ",")
            
            var listOfElements: [String] = []
            for entry in splitLine {
                let trimmedEntry = entry.trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
                
                listOfElements.append(trimmedEntry)
            }
            
            let tempLocation = Location(key: listOfElements[SaveEquivalencies.Key.rawValue], name: listOfElements[SaveEquivalencies.Name.rawValue], latitude: listOfElements[SaveEquivalencies.Latitude.rawValue], longitude: listOfElements[SaveEquivalencies.Longitude.rawValue], streetAddress: listOfElements[SaveEquivalencies.StreetAddress.rawValue], city: listOfElements[SaveEquivalencies.City.rawValue], state: listOfElements[SaveEquivalencies.State.rawValue], zip: listOfElements[SaveEquivalencies.Zip.rawValue], type: listOfElements[SaveEquivalencies.LocationType.rawValue], phone: listOfElements[SaveEquivalencies.Phone.rawValue], website: listOfElements[SaveEquivalencies.Website.rawValue])
            
            // Makes sure data is not overwritten
            if locations[tempLocation.key] == nil {
                locations[tempLocation.key] = tempLocation
            }
        }
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: locations)

        UserDefaults.standard.set(encodedData, forKey: "Locations")
    }
    
    /**
     * Returns a dictionary with the location's key and the location itself as the two components
     */
    func returnListOfLocations() -> [String: Location]
    {
        var locations: [String: Location] = [:]
        if let data = UserDefaults.standard.data(forKey: "Locations") {
            locations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Location] ?? [:]
        }
        return locations
    }
    
    /**
     * After making changes to a location (updating the donation item inventory there), updated here
     */
    func updateLocations(locations: [String: Location])
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: locations)
        
        UserDefaults.standard.set(encodedData, forKey: "Locations")
    }    
}
