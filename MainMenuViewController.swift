//
//  MainMenuViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // Variables
    
    var user: User!
        
    /**
     * Handles set-up when the view has already loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /**
     * Handles the back press; takes users back to the Welcome screen (ViewController)
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
