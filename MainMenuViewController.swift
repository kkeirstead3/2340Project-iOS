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
    
    // Outlets
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    
    /**
     * Handles set-up when the view has already loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        NameLabel.text = user.name
        EmailLabel.text = user.email
        PasswordLabel.text = user.password
        CategoryLabel.text = user.category.rawValue
    }
    
    /**
     * Handles the back press; takes users back to the Welcome screen (ViewController)
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
