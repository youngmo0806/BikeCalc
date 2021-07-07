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
    
    var picker: UIPickerView!
    var exitBtn: UIBarButtonItem!
    var toolbar: UIToolbar!
    let bikeKind = ["1년미만","1년","2년","3년","4년","5년","6년"] //중고일때만 적용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        bikePrice.delegate = self
        
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
        
        if bikePrice.text == "" || bikeCc.text == "" || bikeYear.text == "" {
            DispatchQueue.main.async {
                Util.shared.alert(title: "", message: "입력값을 확인해주세요.")
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
}

//MARK:- pickerView
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

extension StepTwoController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(textField)
        print(string)//들어온 값들
        print(range)//현재 textFile의 전체 길이
        
        
        return true
    }
}
