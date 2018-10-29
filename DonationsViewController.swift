//
//  DonationsViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/14/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class DonationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variables
    
    var location: Location!
    var selectedItem: DonationItem? = nil
    
    // Actions
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlets

    @IBOutlet weak var DonationsTV: UITableView!
    
    /**
     * Set up for the table view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DonationsTV.delegate = self
        DonationsTV.dataSource = self
    }
    
    /********************************************************
     ********************************************************/
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (location.donations.count)
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        if (location.donations.count) > 0 {
            cell?.textLabel!.text = location.donations[indexPath.row].shortDescription
        }
        
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DonationsTV.deselectRow(at: indexPath, animated: true)
        
        selectedItem = location.donations[indexPath.row]
        
        performSegue(withIdentifier: "ShowItemInfo", sender: nil)
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }

    /**
     * Sets the location and item to be used in the donation info view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DonationInfoViewController
        destinationVC.location = self.location
        destinationVC.selectedItem = self.selectedItem
    }
}
