//
//  StepThreeController.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/08.
//

import UIKit
import GoogleMobileAds

class StepThreeController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google 광고 소스//
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = DeviceManager.shared.adUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        homeBtn.layer.cornerRadius = 15
        
        let formetter = NumberFormatter()
        formetter.numberStyle = .decimal
        formetter.maximumFractionDigits = 0
        
        if let resultPrice = formetter.string(from: NSNumber(value: DeviceManager.shared.total)) {
            result.text = resultPrice + "원 입니다."
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        //home
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }
}
