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
