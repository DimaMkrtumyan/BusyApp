//
//  BranchTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 04.05.22.
//

import UIKit

class BranchTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
