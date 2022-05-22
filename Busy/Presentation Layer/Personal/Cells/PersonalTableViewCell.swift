//
//  PersonalTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 12.02.22.
//

import UIKit

class PersonalTableViewCell: UITableViewCell {
    @IBOutlet weak var cellNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLabel() {
        cellNameLabel.textColor = UIColor(named: "CustomRed")
    }
}
