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
    
    // Actions
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlets
    
    @IBOutlet weak var InfoScrollView: UIScrollView!
    
    /**
     * Calls set up for the scroll view
     */
    override func viewDidAppear(_ animated: Bool) {
        setUpScrollView()
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
}
