//
//  OrderCategoryCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 04.02.22.
//

import UIKit

class OrderNetworkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var id: Int?
    var reservations = [CartReservations]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupContent(network: CartNetwork) {
        cafeNameLabel.text = network.name
        id = network.networkId
        reservations.append(contentsOf: network.reservations)
    }
}

