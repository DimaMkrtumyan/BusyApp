//
//  ItemFooterView.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import UIKit

class ItemFooter: UICollectionReusableView {
    static let reuseId = "ItemFooter"
    var addButton = UIButton()
    var likeButton = UIButton()
    
    func setupContent() {
        likeButton.frame = CGRect(x: frame.width - 79, y: 25, width: 55, height: 55)
        likeButton.setImage(UIImage(named: "heart3"), for: .normal)
        likeButton.layer.cornerRadius = 8
        addSubview(likeButton)
        addButton.frame = CGRect(x: 24, y: 25, width: frame.width - likeButton.frame.width, height: 55)
        addButton.setTitle("Ավելացնել զամբյուղում", for: .normal)
        addButton.backgroundColor = UIColor(named: "CustomRed")
        addButton.layer.cornerRadius = 8
    }
}
