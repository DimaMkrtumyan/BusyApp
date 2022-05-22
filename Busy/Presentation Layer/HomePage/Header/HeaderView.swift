//
//  HeaderView.swift
//  Busy
//
//  Created by Davit Muradyan on 30.12.21.
//
import UIKit

protocol HeaderViewDelegate: AnyObject {
    func allPressed(type: Int)
}

class HeaderView: UICollectionReusableView {
    
    static let reuseId = "HeaderView"
    var categoryLabel = UILabel()
    var allButton = UIButton()
    weak var delegate: HeaderViewDelegate?
    var type: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        categoryLabel.frame = CGRect(x: 16, y: 15, width: 200, height: 17)
        categoryLabel.font = UIFont(name: "Montserratarm-Medium", size: 22)
        addSubview(categoryLabel)
        allButton.frame = CGRect(x: self.frame.width - 87, y: 0, width: 79, height: 36)
        allButton.center.y = categoryLabel.center.y
        allButton.backgroundColor = UIColor(named: "CustomRed")
        allButton.setTitle("Բոլորը", for: .normal)
        allButton.titleLabel?.font = UIFont(name: "Montserratarm-Regular", size: 13)
        allButton.layer.cornerRadius = 4
        allButton.addTarget(self, action: #selector(allPressed), for: .touchUpInside)
        addSubview(allButton)
    }
    
    func setupName(section: RestuarantSection) {
        categoryLabel.text = section.typeName
    }
    
    @objc func allPressed() {
        delegate?.allPressed(type: type!)
    }
}
