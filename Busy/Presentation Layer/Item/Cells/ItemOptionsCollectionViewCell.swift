//
//  ItemOptionsCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 08.02.22.
//

import UIKit

class ItemOptionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var id: Int?
    var isVariantSelected = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectButton.isUserInteractionEnabled = false
    }
    
    func setupContent(item: String, itemData: OrderItemData) {
        attributeLabel.text = item
        id = itemData.id
    }
}
