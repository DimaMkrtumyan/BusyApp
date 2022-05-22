//
//  CodeView.swift
//  Busy
//
//  Created by Davit Muradyan on 07.12.21.
//

import UIKit

class CodeView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "CodeView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
