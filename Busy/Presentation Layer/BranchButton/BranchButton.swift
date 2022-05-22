//
//  BranchButton.swift
//  Busy
//
//  Created by Davit Muradyan on 11.02.22.
//

import UIKit

class BranchButton: UIButton {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var downImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
//        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "BranchButton", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    @objc func pressed() {
        print("asd")
    }
}
