//
//  FavHeaderView.swift
//  Busy
//
//  Created by Davit Muradyan on 14.01.22.
//

import UIKit

protocol OpenPageTappedDelegate: AnyObject {
    func buttonTapped()
}
class FavHeaderView: UICollectionReusableView {
 
    weak var delegate: OpenPageTappedDelegate?
    var restuarantNameLabel = UILabel()
    var openRestuarantPageBtn = UIButton()
    var addressContainerView = UIView()
    var addressLabel = UILabel()
    var dropDownIV = UIImageView()
    
    func setupContent(_ restuarantName: String,_ addressName: String) {
        openRestuarantPageBtn.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        restuarantNameLabel.text = restuarantName
        restuarantNameLabel.font = UIFont(name: "Montserratarm-Medium", size: 24)
        openRestuarantPageBtn.setTitle("Բացել էջը", for: .normal)
        openRestuarantPageBtn.setTitleColor(UIColor(named: "CustomRed"), for: .normal)
        openRestuarantPageBtn.titleLabel?.font = UIFont(name: "Montserratarm-Regular", size: 12)
        let textRange = NSRange(location: 0, length: (openRestuarantPageBtn.titleLabel?.text!.count)!)
        let attributedText = NSMutableAttributedString(string: (openRestuarantPageBtn.titleLabel!.text!))
              attributedText.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: textRange)
        openRestuarantPageBtn.setAttributedTitle(attributedText, for: .normal)
        addressContainerView.backgroundColor = .white
        addressLabel.textColor = UIColor(named: "CustomDarkGray")
        addressLabel.text = addressName
        addressLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        dropDownIV.image = UIImage(named: "down1")
        addSubview(restuarantNameLabel)
        addSubview(openRestuarantPageBtn)
        addSubview(addressContainerView)
        addressContainerView.addSubview(addressLabel)
        addressContainerView.addSubview(dropDownIV)
    }
    @objc func handleButton() {
        delegate?.buttonTapped()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        restuarantNameLabel.frame = CGRect(x: 2, y: 24, width: 250, height: 29)
        openRestuarantPageBtn.frame = CGRect(x: frame.width - 67, y: 17, width: 67, height: 44)
        addressContainerView.frame = CGRect(x: 0, y: frame.maxY - 41, width: 176, height: 24)
        addressLabel.frame = CGRect(x: 0, y: 3 , width: 149, height: 16)
        dropDownIV.frame = CGRect(x: addressContainerView.frame.width - 24, y: 0, width: 24, height: 23)
    }
    
    
    @IBAction func adressTapped(_ sender: UITapGestureRecognizer) {
        
    }
}
