//
//  ViewController.swift
//  BikeCalc
//
//  Created by kbins on 2021/03/24.
//
//바이크 등록 세금 계산기

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var NvItemBar: UINavigationItem!
    let adView = ADViewController()
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            var testBtn = UIButton(frame: CGRect(x: self.view.center.x , y: self.view.center.y, width: 100, height: 100))
            testBtn.setTitle("Test", for: .normal)
            view.addSubview(testBtn)
        #endif
        
        //Google 광고 소스//
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = DeviceManager.shared.adUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        navigationController?.isNavigationBarHidden = true
        startBtn.layer.cornerRadius = 15
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    //네트워크 체크
    func checkNetwork(){
        if DeviceManager.shared.networkStatus {
            //정상실행
            
        }else{
            let alert: UIAlertController = UIAlertController(title: "네트워크 상태 확인", message: "네트워크가 불안정 합니다.", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "다시시도", style: .default) { (YOUNGMO) in
                self.checkNetwork()
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
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

