//
//  TextField+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 06.12.21.
//

import UIKit

extension UITextField {
    
    func setupLeftView() {
        let labelContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 48))
        leftView = labelContainerView
        leftViewMode = .always
    }
    func setupRightViewIcon(_ iconName: String) {
        let icon = UIImageView(frame:CGRect(x: 0, y: 8, width: 16, height: 16))
        icon.image = UIImage(named: iconName)
        icon.tintColor = UIColor(named: "CustomDarkGray")
        let iconContainerView: UIView = UIView(frame:CGRect(x: 10, y: 0, width: 32, height: 32))
        iconContainerView.addSubview(icon)
        rightView = iconContainerView
        rightViewMode = .always
    }
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar
    }
}
