//
//  UIImageView+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 07.01.22.
//

import UIKit
import ImageLoader

extension UIImageView {
    func load(str: String) {
        let url = URL(string: str)
        if let url = url {
            self.load.request(with: url)
        } else {
            self.load(str: "https://bucket-busy.s3.us-east-1.amazonaws.com/NotificationIcons/Rectangle%2021NotLogo.png")
        }
    }
}
