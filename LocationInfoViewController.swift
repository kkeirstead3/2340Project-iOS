//
//  LocationInfoViewController.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 10/5/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class LocationInfoViewController: UIViewController {

    // Variables
    
    var location: Location! = nil
    var user: User! = nil
    
    // Actions
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlets
    
    @IBOutlet weak var InfoScrollView: UIScrollView!
    @IBOutlet weak var AddDonationButton: UIButton!
    @IBOutlet weak var ViewDonationsButton: UIButton!
    
    /**
     * Calls set up for the scroll view
     */
    override func viewDidAppear(_ animated: Bool) {
        
        setUpScrollView()
        
        if user.category == Category.UserTypes.User {
            let existingFrame = InfoScrollView.frame
            let height = UIScreen.main.bounds.height - existingFrame.origin.y - 16
            
            InfoScrollView.frame = CGRect(x: existingFrame.origin.x, y: existingFrame.origin.y, width: existingFrame.width, height: height)
        }
    }
    
    /**
     * Hides the add and view buttons if the person does not have the correct privileges
     */
    override func viewDidLoad() {
        if user.category == Category.UserTypes.User {
            AddDonationButton.isHidden = true
            ViewDonationsButton.isHidden = true
        }
    }
    
    /**
     * Presents the location's data in the scroll view
     */
    func setUpScrollView() {
        
        var yCoord = 0
        var counter = 0;
        
        for attribute in location!.attributes {
            let descriptionLabel:UILabel = UILabel(frame: CGRect(x: 0, y: yCoord, width: Int(InfoScrollView.frame.width), height: 50))

            let valueLabel:UILabel = UILabel(frame: CGRect(x: 0, y: yCoord + 50, width: Int(InfoScrollView.frame.width), height: 50))

            let blackView:UIView = UIView(frame: CGRect(x: 0, y: yCoord + 109, width: Int(InfoScrollView.frame.width), height: 2))
            
            // NOTE: ENUM MUST BE IN SAME ORDER AS CONSTRUCTOR FOR THIS TO WORK
            descriptionLabel.text = Locations.SaveEquivalencies(rawValue: counter)?.description
            
            descriptionLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 204/255, alpha: 1.0)
            
            valueLabel.text = attribute
                        
            blackView.backgroundColor = .black
            
            yCoord += 120
            
            counter += 1
            
            InfoScrollView.addSubview(descriptionLabel)
            
            InfoScrollView.addSubview(valueLabel)
            
            InfoScrollView.addSubview(blackView)
            
        }
        
        InfoScrollView.contentSize = CGSize(width: Int(InfoScrollView.frame.width), height: yCoord)
    }
    
    /**
     * Sets the location to be used in the add item view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let destinationVC = segue.destination as! AddItemViewController
            destinationVC.location = self.location
        } else {
            let destinationVC = segue.destination as! DonationsViewController
            destinationVC.location = self.location
        }
    }
}
