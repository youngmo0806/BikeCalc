//
//  StepTwoController.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/06.
//

import UIKit

class StepTwoController: UIViewController {

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
                DeviceManager.shared.bikePrice = Int(price) ?? 0
                DeviceManager.shared.bikeCC = Int(cc) ?? 0
                DeviceManager.shared.bikeYear = year
            }
            
            calcTax(price: DeviceManager.shared.bikePrice, cc: DeviceManager.shared.bikeCC, year: DeviceManager.shared.bikeYear) {

                print("최종 세금 입니다.[\(DeviceManager.shared.total)]")
//                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepThree") else {
//                    return
//                }
//                self.navigationController?.pushViewController(vc, animated: true)

            }
            
        }
    }
    
    @objc func pickerExit() {
        //picker와 같은 뷰를 닫는 함수
        self.view.endEditing(true)
    }
    
    //세자리 마다 콤마 찍기
    func DecimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        
        return result
    }

    //총 세금 계산
    func calcTax(price: Int, cc: Int, year: String, sucessHandler: () -> Void) {

        print("year: \(year)")

        var rate: Double
        var flagPt: Double = 0.2    //125cc 이하
        
        switch year {
        
            case "1년미만":
                rate = 0.703
            case "1년":
                rate = 0.562
            case "2년":
                rate = 0.464
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
            flagPt = 0.5 //125cc이상
        }
        
        
        //기준 금액을 계산 = 차량 신차가격 * 부가세 * Rate

        
        let averagePrice = (Double(price) * 0.1) * rate
        

        let sum = Int(averagePrice * flagPt)

        print("계산식을 확인해봅니다")
        print("(\(price) * 0.1) * \(rate)")
        print("averagePrice : \(averagePrice)")
        print("\(averagePrice) * \(flagPt)")
        print("sum : \(sum)")
        
        if sum < 0 {
            //계산된 세금이 이상합니다;;
            Util.shared.alert(title: "", message: "세금의 입력값에 문제가 있습니다.")
        }
        else {
            DeviceManager.shared.total = sum
            sucessHandler()
        }
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
    
    /*
     텍스트 필드에 콤마를 찍는 작업을 진행. 음...
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string)       //들어온 값들
        print(range)        //현재 textFile의 전체 길이
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        
        
        
        
        return true
    }
}
