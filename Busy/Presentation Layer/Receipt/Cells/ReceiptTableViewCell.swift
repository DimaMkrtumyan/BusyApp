//
//  ReceiptTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 17.02.22.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var oneItemPrice: UILabel!
    @IBOutlet weak var wholePrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContent(item: ReceiptItem) {
        dishNameLabel.text = item.name
        countLabel.text = "x\(item.count)"
        oneItemPrice.text = "\(item.price) AMD"
        wholePrice.text = "\(item.priceSum) AMD"
    }
}
