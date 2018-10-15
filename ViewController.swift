//
//  ViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    /**
     * Handles set-up when the view has already loaded; calls method to load locations.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initSetUp = InitialSetUp()
        initSetUp.setDonationItemCategories()
        
        let tempLocation = Locations()
        tempLocation.loadLocations()
    }
}

