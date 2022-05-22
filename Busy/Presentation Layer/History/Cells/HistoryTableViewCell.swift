//
//  HistoryTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 17.02.22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var networkName: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupContent(historyOrder: HistoryOrders) {
        logoImageView.load(str: historyOrder.logoUrl)
        networkName.text = historyOrder.networkName
        branchLabel.text = historyOrder.address
        priceLabel.text = "\(historyOrder.totalPrice) AMD"
        id = historyOrder.reservationId
    }
}
