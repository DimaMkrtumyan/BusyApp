//
//  FavouritesViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 13.01.22.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favTableView: UITableView!
    
    let favouritesViewModel = FavouritesViewModel()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTableView()
        getFavRestuarants()
        configRefreshControl()
    }
    
    func getFavRestuarants() {
        showLoader()
        favouritesViewModel.getFavouriteRestuarants { result in
            switch result {
            case .success():
                self.hideLoader()
                self.favTableView.reloadData()
                self.hideLoader()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    func setupTableView() {
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.register(UINib(nibName: "FavRestuarantTableViewCell", bundle: .main), forCellReuseIdentifier: "FavRestuarantTableViewCell")
        favTableView.contentInset.bottom = 10
    }
    
    func configRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pulled), for: .valueChanged)
        favTableView.refreshControl = refreshControl
    }
    
    @objc func pulled() {
        print("asdf")
    }
    
    func determineHeader(_ section: Int) -> String {
        switch section {
        case 0:
            return "Սրճարաններ"
        case 1:
            return "Արագ սննդի կետեր"
        case 2:
            return "Ռեստորաններ"
        default:
            return ""
        }
    }
    
    func goingToFavouiteRest(id: Int, name: String) {
        let favRestVC = storyboard?.instantiateViewController(withIdentifier: "FavRestuarantViewController") as! FavRestuarantViewController
        favRestVC.id = id
        favRestVC.titleName = name
        
        navigationController?.pushViewController(favRestVC, animated: true)
    }
    
    func determineSection(tableView: UITableView, indexPath: IndexPath) ->  UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavRestuarantTableViewCell", for: indexPath) as! FavRestuarantTableViewCell
        switch indexPath.section {
        case 0:
            cell.setupContent(favRestuarant: favouritesViewModel.cafes[indexPath.row])
            return cell
        case 1:
            cell.setupContent(favRestuarant: favouritesViewModel.fastFood[indexPath.row])
            return cell
        case 2:
            cell.setupContent(favRestuarant: favouritesViewModel.restuarants[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favouritesViewModel.cafes.count
        case 1:
            return favouritesViewModel.fastFood.count
        case 2:
            return favouritesViewModel.restuarants.count
        default:
            return -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return determineSection(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let title = UILabel(frame: CGRect(x: 24, y: 5, width: tableView.frame.width , height: 29))
        title.font = UIFont(name: "Montserratarm-Medium", size: 24)
        title.text = determineHeader(section)
        headerView.addSubview(title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FavRestuarantTableViewCell
        goingToFavouiteRest(id: cell.id, name: cell.favRestuarantLabel.text!)
    }
}
