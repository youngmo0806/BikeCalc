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
    @IBOutlet weak var bikeYear: UITextField!
    @IBOutlet var orignalView: UIView!
    
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var calc: UIButton!
    
    var picker: UIPickerView!
    var exitBtn: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    let bikeKind:[(key: String, value: Int)] = [("1년미만",0), ("1년",1), ("2년",2), ("3년",3), ("4년",4), ("5년",5), ("6년",6)] //중고일때만 적용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startBtn.layer.cornerRadius = 15
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
        else if bikeYear.text == "" {
            message = "출고연식을 확인해주세요."
            bikeYear.becomeFirstResponder()
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
                
                
//                DeviceManager.shared.bikeYear = year
            }
            
//            calcTax(price: DeviceManager.shared.bikePrice, cc: DeviceManager.shared.bikeCC, year: DeviceManager.shared.bikeYear) {
//
//                print("최종 세금 입니다.[\(DeviceManager.shared.total)]")
////                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepThree") else {
////                    return
////                }
////                self.navigationController?.pushViewController(vc, animated: true)
//
//            }
            
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
        
        //신차가격 700만 원의 모터바이크를 중고로 구매했고
        //최초 등록 후 1년이 지났다면 실제 거래가격이 아닌 0.562%를 적용하여
        //7,000,000×0.562=3,934,000이라는 가치가 차량 가격으로 책정되며
        //이 금액과 신고금액 중 높은 금액을 기준으로 세금이 매겨진다. 취등록세는 0.05이므로,
        //3,934,000×0.05=196,700이라는 값이 나오기 때문에 19만 6천7백 원이다.
        //실제 적용은 차량 모델 별 과표에 따라 매겨지므로 소폭의 차이가 있을 수 있다.
        
        let sum = price * cc

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
        return self.bikeKind[row].key
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bikeKind.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bikeYear.text = bikeKind[row].key
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
