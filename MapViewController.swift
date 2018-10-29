//
//  MapViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/28/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    // Variables
    
    var locations: [String: Location]? = [:]
    
    // Outlets
    
    @IBOutlet weak var mapHolder: GMSMapView!

    // Actions
    
    /**
     * Handles the back press and returns the user to the main menu
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Sets the pins on the map to the saved locations and where the map should be centered
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.data(forKey: "Locations") {
            locations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Location]
        }
        
        var camera: GMSCameraPosition?
        
        for location in locations!.values {
    
            if camera == nil {
                camera = GMSCameraPosition.camera(withLatitude: Double(location.latitude)!, longitude: Double(location.longitude)!, zoom: 8.0)
                mapHolder.camera = camera!
            }
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
            marker.title = location.name
            marker.snippet = location.phone
            marker.map = mapHolder
        }
    }
}
