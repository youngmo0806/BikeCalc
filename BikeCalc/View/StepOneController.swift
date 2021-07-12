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
        
//        #548CA8
//        #476072
//        let testColor = UIColor(rgb: #548CA8)
        buttonDesign(newBike, UIColor(red: 93, green: 130, blue: 5))
        buttonDesign(oldBike, UIColor(red: 40, green: 78, blue: 120))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("[\(segue.identifier!)] 를 선택!")
        
        if segue.identifier == "new" {
            DeviceManager.shared.bikeState = true
        } else if segue.identifier == "used" {
            DeviceManager.shared.bikeState = false
        }
        
    }
    
    
    @IBAction func gotoHome(_ test: UIStoryboardSegue){
        print("home 으로 돌아옴")
    }
}



