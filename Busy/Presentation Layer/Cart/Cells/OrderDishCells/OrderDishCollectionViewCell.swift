//
//  OrderDishCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 04.02.22.
//

import UIKit

class OrderDishCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dishLogoImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishCountLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var dishDetailsLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    var count = 0
    var id: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInnerViews()
    }
    
    func setupInnerViews() {
        minusButton.layer.borderWidth = 2
        minusButton.layer.borderColor = UIColor(named: "CustomGray")?.cgColor
        minusButton.layer.cornerRadius = minusButton.frame.width / 2
        plusButton.layer.borderWidth = 2
        plusButton.layer.borderColor = UIColor(named: "CustomGray")?.cgColor
        plusButton.layer.cornerRadius = plusButton.frame.width / 2
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(String(describing: priceLabel.text)) AMD")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        priceLabel.attributedText = attributeString
    }
    
    func setupContent(item: CartItems) {
        dishLogoImageView.load(str: item.picUrl)
        dishNameLabel.text = item.name
        dishCountLabel.text = "\(item.count)"
//        dishDetailsLabel.text = item.parameterNames[0]
        priceLabel.text = "\(item.price) AMD"
        discountedPriceLabel.text = "\(item.discountedPrice) AMD"
        count = item.count
    }
    @IBAction func minusPressed(_ sender: UIButton) {
        if count > 0 {
            count -= 1
            dishCountLabel.text = "\(count)"
        }
    }
    @IBAction func plusPressed(_ sender: UIButton) {
        count += 1
        dishCountLabel.text = "\(count)"
    }
}

