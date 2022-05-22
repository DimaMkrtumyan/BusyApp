//
//  PersonalViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 12.02.22.
//

import UIKit

class PersonalViewController: UIViewController {
    @IBOutlet weak var personalTableView: UITableView!
    
    let personalViewModel = PersonalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPersonalDetails()
        setupTableView()
    }
    
    func getPersonalDetails() {
        showLoader()
        personalViewModel.getPersonalDetails { result in
            switch result {
            case .success(_):
                self.hideLoader()
                self.personalTableView.reloadSections(IndexSet(integer: 0), with: .fade)
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    private func signOut() {
        showLoader()
        personalViewModel.signOut { result in
            switch result {
            case .success(_):
                self.hideLoader()
                self.navigationController?.popToViewController((self.navigationController?.viewControllers.first)!, animated: true)
//                self.goingToSubPages(storyBoardName: "Login", identifier: "LoginViewController")
            case .failure(let error):
                self.hideLoader()
                print(error)
            }
        }
    }
    
    func setupTableView() {
        personalTableView.delegate = self
        personalTableView.dataSource = self
        personalTableView.register(UINib(nibName: "PersonalTableViewCell", bundle: .main), forCellReuseIdentifier: "PersonalTableViewCell")
    }
    
    func goingToSubPages(storyBoardName: String, identifier: String) {
        let subVC = UIStoryboard(name: storyBoardName, bundle: .main).instantiateViewController(withIdentifier: identifier)
        navigationController?.pushViewController(subVC, animated: true)
    }
    
    func setupFirstHeaderView(name: String, phoneNumber: String, busyCoins: Int, icon: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: personalTableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let logoImageView = UIImageView(frame: CGRect(x: 24, y: 24, width: 60, height: 60))
        logoImageView.load(str: icon)
        logoImageView.backgroundColor = .lightGray
        logoImageView.layer.cornerRadius = logoImageView.frame.width / 2
        let nameLabel = UILabel(frame: CGRect(x: logoImageView.frame.maxX + 12, y: logoImageView.frame.minY + 10, width: 150, height: 20))
        nameLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        nameLabel.text = name
        let phoneLabel = UILabel(frame: CGRect(x: nameLabel.frame.minX, y: nameLabel.frame.maxY + 4, width: 150, height: 16))
        phoneLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        phoneLabel.textColor = UIColor(named: "CustomDarkGray")
        phoneLabel.text = phoneNumber
        let busyCoinsLabel = UILabel(frame: CGRect(x: view.frame.width - 100, y: nameLabel.frame.midY, width: 50, height: 12))
        busyCoinsLabel.textAlignment = .center
        busyCoinsLabel.font = UIFont(name: "Montserratarm-Medium", size: 12)
        busyCoinsLabel.textColor = UIColor(named: "CustomRed")
        busyCoinsLabel.text = "\(busyCoins)"
        let additionalLabel = UILabel(frame: CGRect(x: 0, y: busyCoinsLabel.frame.maxY + 1, width: 120, height: 12))
        additionalLabel.center.x = busyCoinsLabel.center.x
        additionalLabel.textAlignment = .center
        additionalLabel.font = UIFont(name: "Montserratarm-Medium", size: 12)
        additionalLabel.textColor = UIColor(named: "CustomDarkGray")
        additionalLabel.text = "BCoin-ներ"
        let sectionLabel = UILabel(frame: CGRect(x: 24, y: logoImageView.frame.maxY + 24, width: personalTableView.frame.width - 48, height: 20))
        sectionLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        sectionLabel.text = "Անձնական կարգավորումներ"
        headerView.addSubview(logoImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(phoneLabel)
        headerView.addSubview(busyCoinsLabel)
        headerView.addSubview(additionalLabel)
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    func setupSimpleHeaderView(sectionName: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: personalTableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let sectionLabel = UILabel(frame: CGRect(x: 24, y: headerView.center.y, width: personalTableView.frame.width - 48, height: 20))
        sectionLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        sectionLabel.text = sectionName
        headerView.addSubview(sectionLabel)
        return headerView
    }
}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return personalViewModel.personalSettings.count
        case 1:
            return personalViewModel.orders.count
        case 2:
            return personalViewModel.other.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalTableViewCell", for: indexPath) as! PersonalTableViewCell
        switch indexPath.section {
        case 0:
            cell.cellNameLabel.text = personalViewModel.personalSettings[indexPath.row]
        case 1:
            cell.cellNameLabel.text = personalViewModel.orders[indexPath.row]
        case 2:
            cell.cellNameLabel.text = personalViewModel.other[indexPath.row]
            if indexPath.row == personalViewModel.other.count - 1 {
                cell.setupLabel()
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return setupFirstHeaderView(name: personalViewModel.name , phoneNumber: personalViewModel.phoneNumber, busyCoins: personalViewModel.busyCoins, icon: personalViewModel.iconUrl)
        case 1:
          return setupSimpleHeaderView(sectionName: "Պատվերներ")
        case 2:
            return setupSimpleHeaderView(sectionName: "Այլ")
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 144
        case 1,2:
            return 36
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                goingToSubPages(storyBoardName: "Cards", identifier: "CardsViewController")
            } else {
                let settingsVC = UIStoryboard(name: "Settings", bundle: .main).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                settingsVC.name = personalViewModel.name
                settingsVC.phone = personalViewModel.phoneNumber
                settingsVC.dob = personalViewModel.birthDate
                settingsVC.image = personalViewModel.iconUrl
                settingsVC.delegate = self
                navigationController?.pushViewController(settingsVC, animated: true)
            }
        case 1:
            if indexPath.row == 0 {
                goingToSubPages(storyBoardName: "ActiveOrders", identifier: "ActiveOrdersViewController")
            } else {
                goingToSubPages(storyBoardName: "History", identifier: "HistoryViewController")
            }
            
        case 2:
            if indexPath.row == 1 {
                goingToSubPages(storyBoardName: "Contacts", identifier: "ContactsViewController")
            }
            else if indexPath.row == 3 {
                signOut()
            }

        default:
            print("default")
        }
    }
}

extension PersonalViewController: UserUpdatedDelegate {
    func saveSuccess() {
        self.getPersonalDetails()
    }
}
