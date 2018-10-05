//
//  LocationsViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/5/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variables
    
    var locations: Array<Location>? = []
    var selectedLocation: Location? = nil
    
    // Actions
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlets
    
    @IBOutlet weak var LocationsTV: UITableView!
    
    
    /**
     * Handles set-up when the view has already loaded; retrieves locations from UserDefaults.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        LocationsTV.delegate = self
        LocationsTV.dataSource = self
        
        if let data = UserDefaults.standard.data(forKey: "Locations") {
            locations = NSKeyedUnarchiver.unarchiveObject(with: data) as? Array<Location>
        }

        // Do any additional setup after loading the view.
    }

    /**
     * Sets the location to be used in the info view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LocationInfoViewController
        destinationVC.location = self.selectedLocation
    }

    /********************************************************
     ********************************************************/
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (locations?.count ?? 0)
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        }
        if (locations?.count ?? 0) > 0 {
            cell?.textLabel!.text = locations![indexPath.row].name
            cell?.detailTextLabel!.text = "\(locations![indexPath.row].city), \(locations![indexPath.row].state)"
        }
        
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        LocationsTV.deselectRow(at: indexPath, animated: true)
        
        selectedLocation = locations![indexPath.row]
        
        performSegue(withIdentifier: "ShowLocationInfo", sender: nil)
    }
    
    /********************************************************
     ********************************************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
   
}
