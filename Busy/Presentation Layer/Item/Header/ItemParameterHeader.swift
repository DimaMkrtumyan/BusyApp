//
//  ItemParameterHeader.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import Foundation
import UIKit

class ItemParameterHeader: UICollectionReusableView {
    static let reuseId = "ItemParameterHeader"
    var parameterLabel = UILabel()
    
    func setupContent(parameter: String) {
        parameterLabel.frame = CGRect(x: 24, y: 16, width: frame.width - 48, height: 21)
        parameterLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        parameterLabel.text = parameter
        addSubview(parameterLabel)
    }
}
