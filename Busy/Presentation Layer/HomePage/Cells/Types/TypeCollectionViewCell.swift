//
//  TypeCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        containerView.layer.cornerRadius = 8
    }
    
    func setupContent(type: RestuarantSection) {
        containerView.layer.cornerRadius = 8
        categoryImageView.image = UIImage(systemName: "fork.knife.circle.fill")
        categoryNameLabel.text = type.typeName
    }
    
    func setupContentForAll(type: AllFlags) {
        containerView.layer.cornerRadius = 8
        categoryNameLabel.text = type.name
    }
}
