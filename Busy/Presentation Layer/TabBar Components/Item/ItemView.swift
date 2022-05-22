//
//  ItemView.swift
//  Busy
//
//  Created by Davit Muradyan on 20.12.21.
//

import UIKit

class ItemView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "Item", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
