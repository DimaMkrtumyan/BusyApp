//
//  FavDishCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 13.01.22.
//

import UIKit

class FavDishCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unlikeButton: UIButton!
    
    var id: Int?
    var didPressOnce = false
    
    private let favouritesViewModel = FavouritesViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInnerDesign()
        
    }
    
    private func checkHeartButton() {
        if didPressOnce {
            unlikeButton.setImage(UIImage(named: "filledHeart"), for: .normal)
            didPressOnce.toggle()
        } else {
            unlikeButton.setImage(UIImage(named: "Heart"), for: .normal)
            didPressOnce.toggle()
        }
    }
    
    func setFavourite() {
        favouritesViewModel.setFavourites(itemId: id!) { [self] result in
            switch result {
            case .success():
                checkHeartButton()
            case .failure(_):
                print("Could not set favourite")
            }
        }
    }
    
    func setupContent(favItem: FavouriteItem) {
        dishImageView.load(str: favItem.picUrl)
        dishNameLabel.text = favItem.name
        priceLabel.text = String(favItem.price)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
    }
    @IBAction func heartButtonPressed(_ sender: UIButton) {
        setFavourite()
    }
}
