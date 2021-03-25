//
//  ViewController.swift
//  BikeCalc
//
//  Created by kbins on 2021/03/24.
//
// 바이크 등록 세금 계산기
//신차 1.0
//1년미만 0.703
//1년 0.562
//2년 0.464
//3년 0.316
//4년 0.215
//5년 0.147
//6년 0.1

//신차 가격 700만원의 모터바이크를 중고로 구매했고 최초 등록후 1년이 지났다면 실제 거래가격이 아닌 0.562를 적용하여
//7,000,000 * 0.562 = 3,934,000 이라는 가치가 차량 가격으로 책정되며 이금액과 신고금액 중 높은 금액을 기준으로 세금이 매겨진다.
//취등록세는 0.05 이므로, 3,934,000 * 0.05 = 196,700 이라는 값이 나오기 때문에 19만 6천7백원이다.
//실제 적용은 차량 모델 별 과표에 따라 매겨지므로 소폭의 차이가 있을 수 있다.



import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var bikePrice: UITextField!
    @IBOutlet weak var bikeAge: UITextField!
    
    
    let bikeYear = ["신차","1년미만","1년","2년","3년","4년","5년","6년이상"]
    
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        createPickView()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    
    
    //MARK:- PickView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bikeYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bikeYear[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bikeAge.text = bikeYear[row]
    }
    
    
    //MARK:- Func
    //keboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createPickView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        bikeAge.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action:nil)
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        bikeAge.inputAccessoryView = toolBar
    }
    
    
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

