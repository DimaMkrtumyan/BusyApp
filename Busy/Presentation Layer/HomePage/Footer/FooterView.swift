//
//  FooterView.swift
//  Busy
//
//  Created by Davit Muradyan on 30.12.21.
//

import UIKit

protocol FooterViewDeleage: AnyObject {
    func textFieldShouldBeginEditing( _ textfield: UITextField)
    func activeOrdersPressed()
}

class FooterView: UICollectionReusableView {
    
    static let reuseId = "FooterView"
    let searchTextField = UITextField()
    let activeOrderView = UIView()
    let activeOrderLabel = UILabel()
    let forwardButton = UIButton()
    
    weak var delegate: FooterViewDeleage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(_ activeOrderCount: Int) {
        searchTextField.frame = CGRect(x: 8, y: 0, width: self.frame.width - 16, height: 48)
        searchTextField.placeholder = "Սրճարան, արագ սննդի կետ, ռեստորան..."
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 4
        searchTextField.backgroundColor = UIColor(named: "CustomGray")
        searchTextField.font = UIFont(name: "Montserratarm-Regular", size: 13)
        searchTextField.setupLeftView()
        searchTextField.setupRightViewIcon("searchIcon")
        searchTextField.delegate = self
        addSubview(searchTextField)
        activeOrderView.frame = CGRect(x: -24, y: searchTextField.frame.maxY + 24, width: self.frame.width + 48, height: 53)
        activeOrderView.backgroundColor = UIColor(named: "CustomGray")
        addSubview(activeOrderView)
        activeOrderLabel.text = "Ակտիվ պատվերներ` \(activeOrderCount)"
        activeOrderLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        activeOrderLabel.frame = CGRect(x: 16, y: 0, width: 200, height: 17)
        activeOrderLabel.center.y = activeOrderView.center.y
        addSubview(activeOrderLabel)
        forwardButton.addTarget(self, action: #selector(activePressed), for: .touchUpInside)
        forwardButton.frame = CGRect(x: self.frame.width - 35, y: 0, width: 44, height: 44)
        forwardButton.center.y = activeOrderView.center.y
        forwardButton.setImage(UIImage(named: "forwardVector"), for: .normal)
        addSubview(forwardButton)
    }
    @objc func activePressed() {
        delegate?.activeOrdersPressed()
    }
}

extension FooterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldBeginEditing(textField)
        return true
    }
}
