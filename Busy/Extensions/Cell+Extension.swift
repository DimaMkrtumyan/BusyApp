//
//  Cell+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 31.12.21.
//

import UIKit

extension UICollectionReusableView {
    
    func select(label: UILabel, logo: UIImageView) {
        label.textColor = .white
        logo.tintColor = .white
        if let cell = self as? TypeCollectionViewCell {
            cell.containerView.backgroundColor = UIColor(named: "CustomRed")
        }
    }
    
    func deselect(label: UILabel, logo: UIImageView) {
        label.textColor = .black
        logo.tintColor = .black
        if let cell = self as? TypeCollectionViewCell {
            cell.containerView.backgroundColor = UIColor(named: "CustomGray")
        }
    }
    
    func setupInnerDesign() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    }
    
    func selectItem() {
        if let cell = self as? ItemOptionsCollectionViewCell {
            cell.selectButton.setImage(UIImage(named: "selected"), for: .normal)
        }
    }
    func deselectItem() {
        if let cell = self as? ItemOptionsCollectionViewCell {
            cell.selectButton.setImage(UIImage(named: "deselected"), for: .normal)
        }
    }
}
