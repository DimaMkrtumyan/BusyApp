//
//  ActiveOrdersViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 16.02.22.
//

import UIKit

class ActiveOrdersViewController: UIViewController {

    @IBOutlet weak var activeOrdersTableView: UITableView!
    
    let activeOrdersViewModel = ActiveOrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getActiveOrders()
    }
    
    func getActiveOrders() {
        showLoader()
        activeOrdersViewModel.getActiveOrders { result in
            switch result {
            case .success():
                self.hideLoader()
                self.activeOrdersTableView.reloadData()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    func setupTableView() {
        activeOrdersTableView.delegate = self
        activeOrdersTableView.dataSource = self
        activeOrdersTableView.register(UINib(nibName: "ActiveOrderTableViewCell", bundle: .main), forCellReuseIdentifier: "ActiveOrderTableViewCell")
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ActiveOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return activeOrdersViewModel.activeOrderItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveOrderTableViewCell", for: indexPath) as! ActiveOrderTableViewCell
        cell.setupContent(item: activeOrdersViewModel.activeOrderItems[indexPath.row])
        cell.delegate = self
        cell.determineCategory(type: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 229
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
}

extension ActiveOrdersViewController: ActiveOrderTableViewCellDelegate {
    func goingToReceiptPage(resId: Int) {
        let receiptVC = UIStoryboard(name: "Receipt", bundle: .main).instantiateViewController(withIdentifier: "ReceiptViewController") as! ReceiptViewController
        receiptVC.id = resId
        navigationController?.pushViewController(receiptVC, animated: true)
    }
}
