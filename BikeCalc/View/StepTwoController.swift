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
    let bikeKind = ["1년미만","1년","2년","3년","4년","5년","6년"] //중고일때만 적용
    
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
        
        DeviceManager
        
        
        
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
    
    
}

//MARK: - pickerViewDelegate
extension StepTwoController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

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
    
    //전기차 충전 공유 앱.
    //간단 상상 => 당근마켓? 앱 구동 근처 반경[지정된] 안에, 공유된 충전소가 있으면 노출,
    //노출된 정보를 보고 구매자는 예약, 충전 포트/충전 량/ 결제 관련 논의,
    //법적 제재의 소지(사업자 업이, 공유자가 경제적 이득을 보는 것에 문제가 없는 프로세스 인지)
    //확인해봐야 할 케이스와 전체적인 점검 및 요건 정리가 필요함.
    //프로토 타입으로 구현 해볼 예정, 참여자 : And - 홍의찬, Server - 서지환, iOS - 정영모
    
}
