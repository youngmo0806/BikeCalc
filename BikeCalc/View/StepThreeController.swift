//
//  StepThreeController.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/08.
//

import UIKit

class StepThreeController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        result.text = String(DeviceManager.shared.total)
    }
    
    
    
    @IBAction func goHome(_ sender: Any) {
        
    }
    
}
