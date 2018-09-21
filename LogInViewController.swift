//
//  LogInViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {

    // Variables
    
    // Outlets
    
    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    // Actions
    
    @IBAction func logInPressed(_ sender: Any) {
        let logInModel = LogInModel()
        let valid = logInModel.validSignIn(username: UsernameTF.text!, password: PasswordTF.text!)
        if (valid) {
            performSegue(withIdentifier: "LogInPressed", sender: nil)
        } else {
            let alert = UIAlertController(title: "Invalid Credentials", message: "Please make sure you enter valid credentials.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    /**
     * Handles set-up when the view has already loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /**
     * Handles reset on back press from main menu
     */
    override func viewWillAppear(_ animated: Bool) {
        UsernameTF.text = ""
        PasswordTF.text = ""
    }
    
    /**
     * Handles the back press; takes users back to the Welcome screen (ViewController)
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
