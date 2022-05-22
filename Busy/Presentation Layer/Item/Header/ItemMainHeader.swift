//
//  ItemMainHeader.swift
//  Busy
//
//  Created by Davit Muradyan on 08.02.22.
//

import UIKit

class ItemMainHeader: UICollectionReusableView {
    
    static let reuseId = "ItemMainHeader"
    var mainImageView = UIImageView()
    var logoImageView = UIImageView()
    var networkNameLabel = UILabel()
    var dishNameLabel = UILabel()
    var detailsLabel = UILabel()
    var discountedLabel = UILabel()
    var priceLabel = UILabel()
    var parameterLabel = UILabel()
    var voidView = UIView()
    
    func setupContent(mainImageName: String, logoImageName: String, networkName: String, dishName: String, detailsName: String, discountedPrice: Int, price: Int, parameter: String) {
        mainImageView.frame = CGRect(x: 24, y: 0, width: frame.width - 48, height: 325)
        mainImageView.layer.cornerRadius = 4
        mainImageView.load(str: mainImageName)
        addSubview(mainImageView)
        logoImageView.frame = CGRect(x: 24, y: mainImageView.frame.maxY + 10, width: 40, height: 40)
        logoImageView.load(str: logoImageName)
        addSubview(logoImageView)
        networkNameLabel.frame = CGRect(x: logoImageView.frame.maxX + 5, y: 0, width: 150, height: 16)
        networkNameLabel.center.y = logoImageView.center.y
        networkNameLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        networkNameLabel.textColor = UIColor(named: "CustomDarkGray")
        networkNameLabel.text = networkName
        addSubview(networkNameLabel)
        dishNameLabel.frame = CGRect(x: 24, y: logoImageView.frame.maxY + 8, width: frame.width - 48, height: 33)
        dishNameLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        dishNameLabel.text = dishName
        addSubview(dishNameLabel)
        detailsLabel.frame = CGRect(x: 24, y: dishNameLabel.frame.maxY + 8, width: frame.width - 48, height: 19)
        detailsLabel.font = UIFont(name: "Montserratarm-Regular", size: 12)
        detailsLabel.textColor = UIColor(named: "CustomDarkGray")
        detailsLabel.text = detailsName
        addSubview(detailsLabel)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(price) դրամ")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        priceLabel.frame = CGRect(x: 24, y: detailsLabel.frame.maxY + 16, width: 100, height: 10)
        priceLabel.font = UIFont(name: "Montserratarm-Regular", size: 8)
        priceLabel.attributedText = attributeString
        addSubview(priceLabel)
        
        discountedLabel.frame = CGRect(x: 24, y: priceLabel.frame.maxY + 3, width: 100, height: 20)
        discountedLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        discountedLabel.text = "\(discountedPrice) դրամ"
        addSubview(discountedLabel)
        parameterLabel.frame = CGRect(x: 24, y: discountedLabel.frame.maxY + 16, width: frame.width - 48, height: 21)
        parameterLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        parameterLabel.text = parameter
        addSubview(parameterLabel)
        voidView.frame = CGRect(x: 24, y: parameterLabel.frame.maxY, width: frame.width - 48, height: 16)
        addSubview(voidView)
    }
}
