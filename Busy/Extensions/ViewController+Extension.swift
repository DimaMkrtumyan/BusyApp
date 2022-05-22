//
//  ViewController+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 07.12.21.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func setupMainLabel(string: String, location: Int, length: Int, color: UIColor, fontSize: CGFloat) -> NSMutableAttributedString {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string)
        myMutableString.setAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat arm SemiBold", size: fontSize)!, NSAttributedString.Key.foregroundColor : color], range: NSRange(location: location, length: length))
        return myMutableString
    }
    
    func setAsRoot() {
        UIApplication.shared.windows.first?.rootViewController = self
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func fixingLength(textField: UITextField, maxLength: Int, range: NSRange, string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func minimizingLength(textField: UITextField, minLength: Int, range: NSRange, string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length >= minLength
    }

    func showSplashLoader() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setBackgroundLayerColor(.clear)
        SVProgressHUD.show()
    }
    
    func showLoader() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor(named: "CustomRed")!)
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.1))
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
}
