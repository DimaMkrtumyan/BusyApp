//
//  SaleCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

class SaleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var saleImage: UIImageView!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var saleDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupContent(restuarantData: String, indexPath: IndexPath) {
        saleImage.load(str: restuarantData)
    }
}
