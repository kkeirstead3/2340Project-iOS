//
//  SearchByNameViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class SearchByNameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // Variables
    
    let tempAddItemModel = AddItemModel()
    let tempLocation = Locations()
    var location: Location? = nil
    var locations: [String: Location]!
    var onScreenItems: [DonationItem] = []
    var selectedItem: DonationItem?

    // Actions

    /**
     * Handles the back press; takes users back to the Search view
     */
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Loads the array of items to show on screen based off the location and entered name
     */
    @IBAction func pressedCheckInventory(_ sender: Any) {
        if location == nil {
            onScreenItems = tempLocation.getListOfItemsForName(name: ItemNameTF.text ?? "")
        } else {
            onScreenItems = location!.getItemsForName(name: ItemNameTF.text ?? "")
        }
        DispatchQueue.main.async{
            self.ItemsTV.reloadData()
        }
    }
    
    // Outlets
    
    @IBOutlet weak var ItemsTV: UITableView!
    @IBOutlet weak var ItemNameTF: UITextField!
    
    /**
     * Set up for the table view
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        ItemsTV.delegate = self
        ItemsTV.dataSource = self
    }
    
    /********************************************************
     ********************************************************/
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onScreenItems.count
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        if onScreenItems.count > 0 {
            cell?.textLabel!.text = onScreenItems[indexPath.row].shortDescription
        }
        
        return cell!
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ItemsTV.deselectRow(at: indexPath, animated: true)
        
        selectedItem = onScreenItems[indexPath.row]
        
        performSegue(withIdentifier: "SearchByNameSegue", sender: nil)
    }
    
    /**
     * Sets the location and item to be used in the donation info view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DonationInfoViewController
        destinationVC.selectedItem = self.selectedItem
        destinationVC.location = selectedItem?.location
    }
}
