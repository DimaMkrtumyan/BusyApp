//
//  OrderDateCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 04.02.22.
//

import UIKit

class OrderDateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    var id: Int?
    var items = [CartItems]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupContent(reservation: CartReservations) {
        dateLabel.text = reservation.orderDate
        id = reservation.cartId
        items.append(contentsOf: reservation.items)
    }
}
