//
//  DateCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    var id: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(activeReservation: ActiveReservations) {
        dateLabel.text = activeReservation.time
        id = activeReservation.id
    }
}
