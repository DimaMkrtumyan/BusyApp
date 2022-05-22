//
//  DishCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

protocol DishCollectionViewCellDelegate: AnyObject {
    func addPressed(id: Int, count: Int, chosenParameters: [String: String])
}

class DishCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discountedLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    let restuarantViewModel = RestuarantViewModel()
    
    weak var delegate: DishCollectionViewCellDelegate?
    
    var id: Int?
    var isFavorite = false
    var didPressOnce = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInnerDesign()
    }
    
    func setupContent(dishData: RestuarantItem) {
        dishImageView.load(str: dishData.picUrl)
        dishNameLabel.text = dishData.name
        priceLabel.text = String(dishData.price)
        if dishData.discountedPrice == 0 {
            discountedLbl.isHidden = true
        } else {
            discountedLbl.isHidden = false
            discountedLbl.attributedText = (String(dishData.discountedPrice) + " " + "դրամ").strikeThrough()
        }
        id = dishData.id
        if dishData.isFavorite {
            heartButton.setImage(UIImage(named: "filledHeart"), for: .normal)
        }
         didPressOnce = dishData.isFavorite
    }
    
    func checkHeartButton() {
        if didPressOnce {
            heartButton.setImage(UIImage(named: "Heart"), for: .normal)
            didPressOnce.toggle()
        } else {
            heartButton.setImage(UIImage(named: "filledHeart"), for: .normal)
            didPressOnce.toggle()
        }
    }
    
    func setFavourite() {
        restuarantViewModel.setFavourites(itemId: id!) { [self] result in
            switch result {
            case .success():
                checkHeartButton()
            case .failure(_):
                print("Could not set favourite")
            }
        }
//        if didPressOnce {
//            heartButton.setImage(UIImage(named: "Heart"), for: .normal)
//            didPressOnce.toggle()
//        } else {
//            heartButton.setImage(UIImage(named: "filledHeart"), for: .normal)
//            didPressOnce.toggle()
//        }
    }
    
    @IBAction func heartButtonPressed(_ sender: UIButton) {
        setFavourite()
    }
    
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        delegate?.addPressed(id: id!, count: 0, chosenParameters: [:])
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
