//
//  LogInViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController, UITextFieldDelegate {

    // Variables
    
    var chosenUser: User? = nil
    
    // Outlets
    
    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
        
    /**
     * Validates the entered user's credentials
     */
    @IBAction func logInPressed(_ sender: Any) {
        let logInModel = LogInModel()
        let user = logInModel.validSignIn(username: UsernameTF.text!, password: PasswordTF.text!)
        if (user != nil) {
            chosenUser = user
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
        
        UsernameTF.delegate = self
        PasswordTF.delegate = self
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

        let _ = textFieldShouldReturn(UsernameTF)
        let _ = textFieldShouldReturn(PasswordTF)

        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Passes the User data to the main menu
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MainMenuViewController
        destinationVC.user = chosenUser
    }
    
    /**
     * Ensures that the keyboard dismisses correctly when Done is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
