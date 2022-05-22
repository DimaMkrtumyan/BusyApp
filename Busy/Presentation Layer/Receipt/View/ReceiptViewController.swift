//
//  ReceiptViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 17.02.22.
//

import UIKit

class ReceiptViewController: UIViewController {
    @IBOutlet weak var receiptTableView: UITableView!
    
    let receiptViewModel = ReceiptViewModel()
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getReceipt()
    }
    
    func setupTableView() {
        receiptTableView.delegate = self
        receiptTableView.dataSource = self
        receiptTableView.register(UINib(nibName: "ReceiptTableViewCell", bundle: .main), forCellReuseIdentifier: "ReceiptTableViewCell")
    }
    
    func getReceipt() {
        showLoader()
        receiptViewModel.getReceipt(resId: id!) { result in
            switch result {
            case .success():
                self.hideLoader()
                self.receiptTableView.reloadData()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptTableViewCell", for: indexPath) as! ReceiptTableViewCell
        cell.setupContent(item: receiptViewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 17, width: 53, height: 53))
        logoImageView.center.x = headerView.center.x - 60
        logoImageView.load(str: receiptViewModel.logo)
        headerView.addSubview(logoImageView)
        let networkLabel = UILabel(frame: CGRect(x: logoImageView.frame.maxX + 5, y: logoImageView.frame.minY, width: 200, height: 20))
        networkLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        networkLabel.text = receiptViewModel.networkName
        headerView.addSubview(networkLabel)
        let addressLabel = UILabel(frame: CGRect(x: networkLabel.frame.minX, y: networkLabel.frame.maxY + 4, width: 200, height: 16))
        addressLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        addressLabel.textColor = UIColor(named: "CustomDarkGray")
        addressLabel.text = receiptViewModel.address
        headerView.addSubview(addressLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        footerView.backgroundColor = .white
        let serviceLabel = UILabel(frame: CGRect(x: 15, y: 16, width: 250, height: 16))
        serviceLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        serviceLabel.text = "10% սպասարկման վճար"
        footerView.addSubview(serviceLabel)
        let serviceFeeLabel = UILabel(frame: CGRect(x: tableView.frame.width - 85, y: 16, width: 100, height: 16))
        serviceFeeLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        serviceFeeLabel.text = receiptViewModel.fee
        footerView.addSubview(serviceFeeLabel)
        let lineView = UIView(frame: CGRect(x: 15, y: serviceFeeLabel.frame.maxY + 16, width: tableView.frame.width - 30, height: 0.5))
        lineView.backgroundColor = UIColor(named: "CustomGray")
        footerView.addSubview(lineView)
        let wholeLabel = UILabel(frame: CGRect(x: 15, y: lineView.frame.maxY + 16, width: 110, height: 16))
        wholeLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        wholeLabel.text = "Ընդհանուր"
        footerView.addSubview(wholeLabel)
        let sumLabel = UILabel(frame: CGRect(x: tableView.frame.width - 85, y: lineView.frame.maxY + 16, width: 100, height: 16))
        sumLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        sumLabel.text = receiptViewModel.total
        footerView.addSubview(sumLabel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
}
