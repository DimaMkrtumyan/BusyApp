//
//  RateTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 16.04.22.
//

import UIKit

class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var bCoinsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        giveBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func giveBorder() {
        noButton.layer.borderWidth = 1
        noButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func yesPressed(_ sender: UIButton) {
    }
    
    @IBAction func noPressed(_ sender: UIButton) {
    }
}
