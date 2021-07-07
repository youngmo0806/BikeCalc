//
//  Util.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/06.
//

import UIKit

class Util: NSObject {
    
    static let shared = Util()
    
    var currentViewController: UIViewController? {
        return self.getTopViewController()
    }
    
    func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    func alert(title:String?, message:String?, positiveCaption:String?=nil, positiveHandler:(()->Void)?=nil, negativeCaption:String?=nil, negativeHandler:(()->Void)?=nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var pCaption = "확인"
        if let caption = positiveCaption {
            pCaption = caption
        }
        alertController.addAction(UIAlertAction(title: pCaption, style: .default, handler: { _ in
            if let handler = positiveHandler {
                handler()
            }
        }))
        
        if let nhandler = negativeHandler {
            var nCaption = "취소"
            if let caption = negativeCaption {
                nCaption = caption
            }
            alertController.addAction(UIAlertAction(title: nCaption, style: .default, handler: { _ in
                nhandler()
            }))
        }
        
        self.currentViewController?.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Keyboard UI Down
extension UIViewController {
    //키보드 내림 처리
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    //전기차 충전 공유 앱.
    //간단 상상 => 당근마켓? 앱 구동 근처 반경[지정된] 안에, 공유된 충전소가 있으면 노출,
    //노출된 정보를 보고 구매자는 예약, 충전 포트/충전 량/ 결제 관련 논의,
    //법적 제재의 소지(사업자 업이, 공유자가 경제적 이득을 보는 것에 문제가 없는 프로세스 인지)
    //확인해봐야 할 케이스와 전체적인 점검 및 요건 정리가 필요함.
    //프로토 타입으로 구현 해볼 예정, 참여자 : And - 홍의찬, Server - 서지환, iOS - 정영모
    
}
