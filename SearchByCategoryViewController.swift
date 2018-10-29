//
//  SearchByCategoryViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class SearchByCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variables
    
    var categories: [String] = []
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
    
    // Outlets
    
    @IBOutlet weak var CategoriesTV: UITableView!
    
    @IBOutlet weak var ItemsTV: UITableView!
    
    
    /**
     * Set up for the table views
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        categories = tempAddItemModel.getStringCategories()
        
        // Make sure location is getting assigned when called from a location
        
        CategoriesTV.delegate = self
        CategoriesTV.dataSource = self
        
        ItemsTV.delegate = self
        ItemsTV.dataSource = self
    }
    
    /********************************************************
     ********************************************************/
    // Both Table Views (Categories / Donation Items)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == CategoriesTV {
            return categories.count
        } else {
            return onScreenItems.count
        }
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == CategoriesTV {
            var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            }
            if categories.count > 0 {
                cell?.textLabel!.text = categories[indexPath.row]
            }
            
            cell?.contentView.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 238/255)
            
            return cell!
        } else {
            var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            }
            if onScreenItems.count > 0 {
                cell?.textLabel!.text = onScreenItems[indexPath.row].shortDescription
            }
            
            return cell!
        }
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == CategoriesTV) {
            CategoriesTV.deselectRow(at: indexPath, animated: false)

            if location == nil {
                onScreenItems = tempLocation.getListOfItemsForCategory(category: categories[indexPath.row])
            } else {
                onScreenItems = location!.getItemsForCategory(category: categories[indexPath.row])
            }
            
            DispatchQueue.main.async{
                self.ItemsTV.reloadData()
            }
        } else {
            ItemsTV.deselectRow(at: indexPath, animated: true)
            
            selectedItem = onScreenItems[indexPath.row]
            
            performSegue(withIdentifier: "SearchByCategorySegue", sender: nil)
        }
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
