//
//  HistoryViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 17.02.22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    let historyViewModel = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHistory()
        setupTableView()
    }
    
    func getHistory() {
        showLoader()
        historyViewModel.getHistory { result in
            switch result {
            case .success():
                self.hideLoader()
                self.historyTableView.reloadData()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    func setupTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: .main), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    func goingToReceiptVC(resId: Int) {
        let receiptVC = UIStoryboard(name: "Receipt", bundle: .main).instantiateViewController(withIdentifier: "ReceiptViewController") as! ReceiptViewController
        receiptVC.id = resId
        navigationController?.pushViewController(receiptVC, animated: true)
    }
    
    @objc func activeViewPressed() {
        let activeOrdersVC = UIStoryboard(name: "ActiveOrders", bundle: .main).instantiateViewController(withIdentifier: "ActiveOrdersViewController")
        navigationController?.pushViewController(activeOrdersVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return historyViewModel.historyModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewModel.historyModel[section].orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        cell.setupContent(historyOrder: historyViewModel.historyModel[indexPath.row].orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
            headerView.backgroundColor = .white
            let activeView = UIView(frame: CGRect(x: 0, y: 24, width: tableView.frame.width, height: 53))
            activeView.backgroundColor = UIColor(named: "CustomGray")
            headerView.addSubview(activeView)
            let activeButton = UIButton(frame: activeView.frame)
            activeButton.backgroundColor = .clear
            activeButton.setTitle("", for: .normal)
            activeButton.addTarget(self, action: #selector(activeViewPressed), for: .touchUpInside)
            headerView.addSubview(activeButton)
            let activeLabel = UILabel(frame: CGRect(x: 24, y: 18, width: 154, height: 17))
            activeLabel.font = UIFont(name: "Montserratarm-Regular", size: 14)
            activeLabel.text = "Ակտիվ պատվերներ"
            activeView.addSubview(activeLabel)
            let rightVector = UIImageView(frame: CGRect(x: tableView.frame.width - 32, y: 0, width: 7, height: 12))
            rightVector.center.y = activeLabel.center.y
            rightVector.image = UIImage(named: "right")
            activeView.addSubview(rightVector)
            let dateLabel = UILabel(frame: CGRect(x: 24, y: activeView.frame.maxY + 32, width: 250, height: 16))
            dateLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
            dateLabel.text = historyViewModel.historyModel[section].date
            headerView.addSubview(dateLabel)
            return headerView
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let dateLabel = UILabel(frame: CGRect(x: 24, y: 32, width: 75, height: 16))
        dateLabel.font = UIFont(name: "Montserratarm-Medium", size: 13)
        dateLabel.text = historyViewModel.historyModel[section].date
        headerView.addSubview(dateLabel)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 137
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        goingToReceiptVC(resId: cell.id!)
    }
}
