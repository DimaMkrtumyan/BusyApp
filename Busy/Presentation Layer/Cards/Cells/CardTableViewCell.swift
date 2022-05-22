//
//  CardTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 16.02.22.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardLogoImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deletePressed(_ sender: UIButton) {
    }
}
