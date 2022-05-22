//
//  FavRestuarantTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 13.01.22.
//

import UIKit

class FavRestuarantTableViewCell: UITableViewCell {
    @IBOutlet weak var favRestuarantImageView: UIImageView!
    @IBOutlet weak var favRestuarantLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupContent(favRestuarant: FavouriteNetwork) {
        favRestuarantImageView.load(str: favRestuarant.logoUrl)
        favRestuarantLabel.text = favRestuarant.name
        offerLabel.text = favRestuarant.description
        id = favRestuarant.id
    }
}
