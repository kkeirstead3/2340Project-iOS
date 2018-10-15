//
//  NewAccountViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/25/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    

    // Variables
    
    var userTypes: [String] = []
    let passwordMinimum = 8
    
    // Objects
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var PickerView: UIPickerView!
    
    // Actions

    /**
     * Handles the back press; takes users back to the Welcome screen (ViewController)
     */
    @IBAction func pressedBack(_ sender: Any) {
        
        let _ = textFieldShouldReturn(nameTF)
        let _ = textFieldShouldReturn(emailTF)
        let _ = textFieldShouldReturn(passwordTF)
        let _ = textFieldShouldReturn(confirmPasswordTF)

        dismiss(animated: true, completion: nil)
    }

    /**
     * Validates the creation of a new account; if valid, goes back to main screen
     */
    @IBAction func pressedCreateAccount(_ sender: Any) {
        
        var alertTitle: String?
        var alertMessage: String?
        var illegalInput: Bool! = false
        
        if (nameTF.text! == ""
            || emailTF.text! == ""
            || passwordTF.text! == ""
            || confirmPasswordTF.text! == "") {
            alertTitle = "Cannot Have Empty Field"
            alertMessage = "Please make sure you have filled in all fields."
            illegalInput = true
        } else if (passwordTF.text! != confirmPasswordTF.text!) {
            alertTitle = "Passwords Do Not Match"
            alertMessage = "Please make sure your confirmed password is the same as your password."
            illegalInput = true
        } else if (passwordTF.text!.count < passwordMinimum) {
            alertTitle = "Passwords Not Long Enough"
            alertMessage = "Please make sure your password is at least \(passwordMinimum) characters long."
            illegalInput = true
        } else {
            let tempNewAccount = NewAccountModel()
            let tempCategory = tempNewAccount.getCategory(selectedCategory: userTypes[PickerView.selectedRow(inComponent: 0)]);
            
            let newUser = User(name: nameTF.text!, email: emailTF.text!, password: passwordTF.text!, category: tempCategory ?? Category.UserTypes.User)
            
            if !tempNewAccount.validateEmail(newUser: newUser) {
                alertTitle = "Email Taken"
                alertMessage = "You must have a unique email for your new account."
                illegalInput = true
            } else {
                // Signifies a new user has successfully been created
                
                let _ = textFieldShouldReturn(nameTF)
                let _ = textFieldShouldReturn(emailTF)
                let _ = textFieldShouldReturn(passwordTF)
                let _ = textFieldShouldReturn(confirmPasswordTF)

                dismiss(animated: true, completion: nil)
            }
        }
        
        if illegalInput {
            let alert = UIAlertController(title: alertTitle!, message: alertMessage!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    /**
     * Handles set-up when the view has already loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self

        PickerView.dataSource = self;
        PickerView.delegate = self;
        
        userTypes = ["User", "Location Employee", "Admin", "Manager"]
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
    }
    
    /**
     * Ensures that the keyboard dismisses correctly when Done is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
