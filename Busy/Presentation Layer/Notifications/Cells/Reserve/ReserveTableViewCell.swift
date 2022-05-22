//
//  ReserveTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 16.04.22.
//

import UIKit

class ReserveTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var reserveHourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func yesPressed(_ sender: UIButton) {
    }
    
}
