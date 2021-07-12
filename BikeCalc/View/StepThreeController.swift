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
        
        homeBtn.layer.cornerRadius = 15
        
        let formeter = NumberFormatter()
        formeter.numberStyle = .decimal
        
        if let resultPrice = formeter.string(from: NSNumber(value: DeviceManager.shared.total)) {
            result.text = resultPrice + "원 입니다."
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        //home
    }
    
}
