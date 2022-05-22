//
//  CustomTabBarViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 13.12.21.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        for i in 0...3 {
            let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
            let bgView = ItemView()
            bgView.initSubviews()
            bgView.frame = CGRect(x: itemWidth * CGFloat(i), y: 0, width: itemWidth, height: tabBar.frame.height)
            tabBar.insertSubview(bgView, at: 0)
            if i == 3 {
                bgView.rightLineView.isHidden = true
            }
        }
    }
//frame: CGRect(x: itemWidth * CGFloat(i), y: 0, width: itemWidth - 1, height: tabBar.frame.height)
}
