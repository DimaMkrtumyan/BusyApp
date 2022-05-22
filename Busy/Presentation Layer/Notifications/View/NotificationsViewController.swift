//
//  NotificationsViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 16.04.22.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var ntfTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        ntfTableView.delegate = self
        ntfTableView.dataSource = self
        ntfTableView.register(UINib(nibName: "RateTableViewCell", bundle: .main), forCellReuseIdentifier: "RateTableViewCell")
        ntfTableView.register(UINib(nibName: "ReserveTableViewCell", bundle: .main), forCellReuseIdentifier: "ReserveTableViewCell")
        ntfTableView.register(UINib(nibName: "OtherTableViewCell", bundle: .main), forCellReuseIdentifier: "OtherTableViewCell")
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableViewCell", for: indexPath) as! RateTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReserveTableViewCell", for: indexPath) as! ReserveTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let rateCell = tableView.cellForRow(at: indexPath) as! RateTableViewCell
//        let reserveCell = tableView.cellForRow(at: indexPath) as! ReserveTableViewCell
//
        return 170
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
