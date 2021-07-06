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
    
//    let bikeYear = ["신차","1년미만","1년","2년","3년","4년","5년","6년이상"]
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google 광고 소스//
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        //~~~~~~~~~~~~~~~~~~~~~~~~//
        
        //navigation controller bar
        navigationController?.isNavigationBarHidden = true
        //createPickView()
        
        startBtn.layer.cornerRadius = 15
    }

    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    //MARK:- Func
    //keboard down
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    func createPickView() {
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        bikeAge.inputView = pickerView
//    }
//
//    func dismissPickerView() {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action:nil)
//        toolBar.setItems([button], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        bikeAge.inputAccessoryView = toolBar
//    }
    
    
    //MARK:- AD
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
    }
    
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

