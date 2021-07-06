//
//  StepOneControllerViewController.swift
//  BikeCalc
//
//  Created by kbins on 2021/03/24.
//

import UIKit
import GoogleMobileAds

class StepOneController: UIViewController{

    
    @IBOutlet weak var newBike: UIButton!
    @IBOutlet weak var oldBike: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonDesign:(UIButton, UIColor) -> Void = {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.backgroundColor = $1
            $0.center.x = self.view.frame.width / 2
        }
        
        buttonDesign(newBike, UIColor.yellow)
        buttonDesign(oldBike, UIColor.red)
        
    }
    
}