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
    @IBOutlet weak var pickView: UIPickerView!
    
    let bikeKind = ["1년미만","1년","2년","3년","4년","5년","6년"] //중고일때만 적용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickView.delegate = self
        self.pickView.dataSource = self
//        DispatchQueue.main.async {
//
//            Util.shared.alert(title: "alert테스트를 진행합니다", message: "아주 정상적으로 테스트를 진행 할수가 있군요", positiveCaption: "포지티브캡션", positiveHandler: {
//                print("positiveCaption")
//            }, negativeCaption: "네거티브캡션") {
//                print("negativeCaption")
//            }
//

    }
    
    @IBAction func calcPrice(_ sender: Any) {
        
        
    }
    
}

//MARK:- pickerView
extension StepTwoController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bikeKind.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.bikeKind[row]
    }



}
