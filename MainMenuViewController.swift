//
//  MainMenuViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Handles the back press; takes users back to the Welcome screen (ViewController)
     */

    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
