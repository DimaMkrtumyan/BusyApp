//
//  RestuarantCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 30.12.21.
//

import UIKit

class RestuarantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restuarantImageView: UIImageView!
    @IBOutlet weak var restuarantLogoImageView: UIImageView!
    @IBOutlet weak var restuarantNameLabel: UILabel!
    @IBOutlet weak var restuarantOffersLabel: UILabel!
    var id: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInnerDesign()
    }
    
    func setContent(restuarant: RestuarantOption) {
        restuarantImageView.load(str: restuarant.imageUrl)
        restuarantLogoImageView.load(str: restuarant.iconUrl)
        restuarantNameLabel.text = restuarant.name
        restuarantOffersLabel.text = restuarant.description
        id = restuarant.id
    }
    
    func setContent(restuarant: SearchedData) {
        restuarantImageView.load(str: restuarant.imageUrl)
        restuarantLogoImageView.load(str: restuarant.iconUrl)
        restuarantNameLabel.text = restuarant.name
        restuarantOffersLabel.text = restuarant.description
        id = restuarant.id
    }
    
    func setContentForAll(restuarant: AllNetworks) {
        restuarantImageView.load(str: restuarant.picUrl)
        restuarantLogoImageView.load(str: restuarant.logoUrl)
        restuarantNameLabel.text = restuarant.name
        restuarantOffersLabel.text = restuarant.description
    }
}
