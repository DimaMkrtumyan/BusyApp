//
//  ContactsViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 21.02.22.
//

import UIKit

class ContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func phoneNumberPressed(_ sender: UIButton) {
        if let url = URL(string: "tel://\(sender.currentTitle!.spacesRemoved)") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func helpButtonPressed(_ sender: UIButton) {
        let email = sender.currentTitle
        let url = URL(string: "mailto:\(email!)")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func mailButtonPressed(_ sender: UIButton) {
        let email = sender.currentTitle
        let url = URL(string: "mailto:\(email!)")
        UIApplication.shared.open(url!)
    }
}
