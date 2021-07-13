//
//  ADViewController.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/13.
//

import UIKit
import GoogleMobileAds

class ADViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setupBannerView() {
        //Google 광고 소스//
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = DeviceManager.shared.adUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
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
