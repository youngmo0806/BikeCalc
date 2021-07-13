//
//  StepTwoController.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/06.
//

import UIKit
import GoogleMobileAds

class StepTwoController: UIViewController, GADBannerViewDelegate {

    
    var bannerView: GADBannerView!
    @IBOutlet weak var bikePrice: UITextField!
    @IBOutlet weak var bikeCc: UITextField!
    
    @IBOutlet weak var bikeYearLabel: UILabel!
    @IBOutlet weak var bikeYear: UITextField!
    @IBOutlet var orignalView: UIView!
    
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var calc: UIButton!
    
    var picker: UIPickerView!
    var exitBtn: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    let bikeKind = ["1년미만", "1년", "2년", "3년", "4년", "5년", "6년"] //중고일때만 적용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google 광고 소스//
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = DeviceManager.shared.adUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bikePrice.layer.borderColor = UIColor.red.cgColor
        bikePrice.layer.borderWidth = 1.0
        bikePrice.attributedPlaceholder = NSAttributedString(string: "차량가액을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        bikeCc.layer.borderColor = UIColor.red.cgColor
        bikeCc.layer.borderWidth = 1.0
        bikeCc.attributedPlaceholder = NSAttributedString(string: "배기량을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray ])
        
        bikeYear.layer.borderColor = UIColor.red.cgColor
        bikeYear.layer.borderWidth = 1.0
        bikeYear.attributedPlaceholder = NSAttributedString(string: "출고년도를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        print("신차 여부 : \(DeviceManager.shared.bikeState)")
        
        if DeviceManager.shared.bikeState { //신차이면
            bikeYearLabel.isHidden = true
            bikeYear.isHidden = true
        }
        
        home.layer.cornerRadius = 15
        calc.layer.cornerRadius = 15
        
        self.hideKeyboardWhenTappedAround()
        bikePrice.delegate = self
        bikeCc.delegate = self
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        //텍스트필드에 뷰를 등록하면, picker는 자동으로 화면 하단에 나타납니다.
        bikeYear.inputView = picker
        
        exitBtn = UIBarButtonItem()
        exitBtn.title = "닫기"
        exitBtn.target = self
        exitBtn.action = #selector(pickerExit)
        
        toolbar = UIToolbar()
        toolbar.tintColor = .darkGray
        //toolbar는 높이만 정해주면 됨, 나머지는 고정된 값 할당 - 높이는 35가 적정
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.setItems([exitBtn], animated: true)
        
        bikeYear.inputAccessoryView = toolbar

    }
    
    @IBAction func moveHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calcPrice(_ sender: Any) {
        var message:String = ""
        
        if bikePrice.text == "" {
            message = "차량가액을 확인해주세요."
            bikePrice.becomeFirstResponder()
        }
        else if bikeCc.text == "" {
            message = "배기량을 확인해주세요."
            bikeCc.becomeFirstResponder()
        }
        
        if !DeviceManager.shared.bikeState {    //중고차일때만 검증
            if bikeYear.text == "" {
                message = "출고연식을 확인해주세요."
                bikeYear.becomeFirstResponder()
            }
        }
        
        if message != "" {
            DispatchQueue.main.async {
                Util.shared.alert(title: "", message: message)
            }
        }
        else {

            if let price = self.bikePrice.text, let cc = self.bikeCc.text, let year = self.bikeYear.text {
                DeviceManager.shared.bikePrice = Int(price.replacingOccurrences(of: ",", with: "")) ?? 0
                DeviceManager.shared.bikeCC = Int(cc.replacingOccurrences(of: ",", with: "")) ?? 0
                DeviceManager.shared.bikeYear = year
            }
            
            calcTax(price: DeviceManager.shared.bikePrice, cc: DeviceManager.shared.bikeCC, year: DeviceManager.shared.bikeYear) {

                print("최종 세금 입니다.[\(DeviceManager.shared.total)]")
                
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepThree") else {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: true)

            }
            
        }
    }
    
    @objc func pickerExit() {
        //picker와 같은 뷰를 닫는 함수
        self.view.endEditing(true)
    }

    //총 세금 계산
    func calcTax(price: Int, cc: Int, year: String, sucessHandler: () -> Void) {
        var rate: Double
        var flagPt: Double = 0.2    //125cc 이하 2%
        
        switch year {
        
            case "1년미만":
                rate = 0.717
            case "1년":
                rate = 0.562
            case "2년":
                rate = 0.455
            case "3년":
                rate = 0.316
            case "4년":
                rate = 0.215
            case "5년":
                rate = 0.147
            case "6년":
                rate = 0.1
            default:
                rate = 1.0
                
        }
            
        if cc >= 125 { //취득세 5프로
            flagPt = 0.5 //125cc 이상 3%
        }
        
        let averagePrice = (Double(price) * 0.1) * rate
        let sum = Int(averagePrice * flagPt)
        
        if sum < 0 {
            //계산된 세금이 이상합니다;;
            Util.shared.alert(title: "", message: "세금의 입력값에 문제가 있습니다.")
        }
        else {
            DeviceManager.shared.total = sum
            sucessHandler()
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

//MARK: - pickerViewDelegate
extension StepTwoController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //pickerView에 뿌릴 데이터
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.bikeKind[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bikeKind.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bikeYear.text = bikeKind[row]
    }

}

//MARK: - UITextFieldDelegate

extension StepTwoController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
        
        // formatter.groupingSeparator // .decimal -> ,
        
        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){ //, -> "" 로 치환
            
            var beforeForemattedString = removeAllSeprator + string
            if formatter.number(from: string) != nil { //숫자일때
                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                    textField.text = formattedString
                    return false
                }
            }else{ // 숫자가 아닐 때먽
                if string == "" { // 백스페이스일때
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                }else{ // 문자일 때
                    return false
                }
            }
        }
        
        return true
    }
}
