//
//  View+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

extension UIView {
    func setCornerRadius(color: UIColor, shadowRadius: CGFloat, offsetHeight: Int) {
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: offsetHeight)
        self.layer.shadowColor = color.cgColor
    }
}
