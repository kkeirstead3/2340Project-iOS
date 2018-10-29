//
//  AddItemViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/11/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // Variables/Constants
    
    var categories: [(String, Bool)] = []
    let tempAddItemModel = AddItemModel()
    let tempLocation = Locations()
    var location: Location!
    var locations: [String: Location]!
    
    // Outlets
    
    @IBOutlet weak var ShortDescriptionTF: UITextField!
    
    @IBOutlet weak var ValueTF: UITextField!
    
    @IBOutlet weak var FullDescriptionTV: UITextView!
    
    @IBOutlet weak var CategoriesTV: UITableView!
    
    @IBOutlet weak var CommentsTF: UITextField!
    
    // Actions
    
    /**
     * Returns the user back to the LocationInfo page without adding an item
     */
    @IBAction func pressedBack(_ sender: Any) {
        
        let _ = textFieldShouldReturn(ShortDescriptionTF)
        let _ = textFieldShouldReturn(ValueTF)
        let _ = textFieldShouldReturn(CommentsTF)

        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Adds a donation item to the list for a specified location
     */
    @IBAction func pressedAddDonation(_ sender: Any) {

        // ADD CHECKING FOR EMPTY FIELDS
        let now = Date()
        let dateFormat = DateFormatter()
        
        dateFormat.timeZone = TimeZone.current
        
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timeStamp = dateFormat.string(from: now)
        let shortDescription: String! = ShortDescriptionTF.text
        let fullDescription: String! = FullDescriptionTV.text
        let value: String! = ValueTF.text
        let comments: String? = CommentsTF.text
        
        let chosenCategories: [String] = tempAddItemModel.getChosenCategories(categories: categories)
        
        if shortDescription != "" && fullDescription != "" && value != "" && chosenCategories != [] {
            let uuidString = UUID().uuidString
            let newDonation = DonationItem(timeStamp: timeStamp, location: location, shortDescription: shortDescription, fullDescription: fullDescription, comments: comments ?? "", value: value, category: chosenCategories, identifier: uuidString)
            
            location.donations.append(newDonation)
            
            locations[location.key] = location
            
            tempLocation.updateLocations(locations: locations)
            
            var testLocations: [String: Location] = [:]
            if let data = UserDefaults.standard.data(forKey: "Locations") {
                testLocations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Location] ?? [:]
            }
            
            for donation in testLocations[location.key]!.donations {
                print(donation)
            }
            
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Empty Fields", message: "Please make sure you enter all requested information.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    /**
     * Set up; used to get the current saved categories and locations
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        ShortDescriptionTF.delegate = self
        ValueTF.delegate = self
        CommentsTF.delegate = self

        categories = tempAddItemModel.getCategories()
        
        locations = tempLocation.returnListOfLocations()
        
        CategoriesTV.delegate = self
        CategoriesTV.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    /********************************************************
     ********************************************************/
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        if categories.count > 0 {
            cell?.textLabel!.text = categories[indexPath.row].0
            if (categories[indexPath.row].1 == false) {
                cell?.accessoryType = UITableViewCell.AccessoryType.none
            } else {
                cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
        
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CategoriesTV.deselectRow(at: indexPath, animated: true)
        
        if (categories[indexPath.row].1 == false) {
            categories[indexPath.row].1 = true
            CategoriesTV.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            categories[indexPath.row].1 = false
            CategoriesTV.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    /**
     * Ensures that the keyboard dismisses correctly when Done is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
