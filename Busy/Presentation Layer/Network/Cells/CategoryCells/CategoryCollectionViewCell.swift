//
//  CategoryCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(category: String) {
        categoryName.text = category
    }
}
