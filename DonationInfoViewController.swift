//
//  DonationInfoViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/14/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class DonationInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variables/Constants
    
    var location: Location!
    var selectedItem: DonationItem! = nil
    var categories: [String] = []
    
    // Outlets
    
    @IBOutlet weak var shortDescriptionTF: UITextField!
    @IBOutlet weak var valueTF: UITextField!
    @IBOutlet weak var fullDescriptionTV: UITextView!
    @IBOutlet weak var categoriesTV: UITableView!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var timeStampTF: UITextField!
    @IBOutlet weak var commentsTF: UITextField!
   
    // Actions
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Fills the views on the screen with the applicable content
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTV.delegate = self
        categoriesTV.dataSource = self
        
        categories = selectedItem!.category

        shortDescriptionTF.text = selectedItem.shortDescription
        fullDescriptionTV.text = selectedItem.fullDescription
        commentsTF.text = (selectedItem.comments == "") ? "No comments" : selectedItem.comments
        valueTF.text = selectedItem.value
        timeStampTF.text = "Time-Stamp: \(selectedItem.timeStamp)"
        locationTF.text = "Location: \(location.name)"
        
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
            cell?.textLabel!.text = categories[indexPath.row]
        }
        
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoriesTV.deselectRow(at: indexPath, animated: true)
    }
}
