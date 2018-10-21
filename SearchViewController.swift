//
//  SearchViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // Variables
    
    var user: User! = nil
    var location: Location! = nil
    
    // Actions
    
    /**
     * Handles the back press; takes users back to the Main Menu
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     * Sets the location for the specific search pages (if it exists)
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorySegue" {
            let destinationVC = segue.destination as! SearchByCategoryViewController
            destinationVC.location = self.location
        } else if segue.identifier == "NameSegue" {
            let destinationVC = segue.destination as! SearchByNameViewController
            destinationVC.location = self.location
        }
    }
}
