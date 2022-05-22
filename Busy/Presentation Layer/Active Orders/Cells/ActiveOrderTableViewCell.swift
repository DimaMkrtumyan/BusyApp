//
//  ActiveOrderTableViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 16.02.22.
//

import UIKit

protocol ActiveOrderTableViewCellDelegate: AnyObject {
    func goingToReceiptPage(resId: Int)
}

class ActiveOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var codeButton: UIButton!
    
    weak var delegate: ActiveOrderTableViewCellDelegate?
    
    var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func determineCategory(type: Int){
        if type == 1 {
            messageLabel.text = "Ձեր սեղանը ամրագրված է։ Կարող եք կատարել պատվերը նախօրոք, սեղմելով «Պատվիրել» կոճակը կամ կատարել և վճարել պատվերը տեղում"
            mainButton.setTitle("Պատվիրել", for: .normal)
            mainButton.backgroundColor = UIColor(named: "CustomRed")
            mainButton.tag = 1
        } else {
            messageLabel.text = ""
            mainButton.setTitle("Տեսնել չեկը", for: .normal)
            mainButton.backgroundColor = UIColor(named: "CustomDarkestGray")
            mainButton.tag = 0
        }
    }
    
    func setupContent(item: ActiveOrderModel) {
        logoImageView.load(str: item.networkIconUrl)
        nameLabel.text = item.networkName
        branchLabel.text = item.address
        dateLabel.text = item.reservationDate
//        messageLabel.text = item.
        codeButton.setTitle("#\(item.cartId)", for: .normal)
        id = item.resId
    }
    
    @IBAction func tagPressed(_ sender: UIButton) {
    }
    
    @IBAction func orderPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            print(1)
        } else {
            delegate?.goingToReceiptPage(resId: id!)
        }
    }
    @IBAction func cancelPressed(_ sender: Any) {
    }
}
