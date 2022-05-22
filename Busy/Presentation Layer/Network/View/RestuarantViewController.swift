//
//  CafeViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 10.12.21.
//

import UIKit

class RestuarantViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case sales
        case dates
        case categories
        case dishes
    }
    
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var freeTablesLabel: UILabel!
    @IBOutlet weak var reservationView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var branchTableView: UITableView!
    @IBOutlet weak var branchTBHeight: NSLayoutConstraint!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var branchLabel: UILabel!
    
    var networkId: Int?
    let restuarantViewModel = RestuarantViewModel()
    var halls = [RestuarantHall]()
    
    var isBranchPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRestuarantData()
        if restuarantViewModel.activeReservations.isEmpty {
            mainCollectionView.collectionViewLayout = createLayout(datesSize: 100)
        } else {
            mainCollectionView.collectionViewLayout = createLayout(datesSize: 100)
        }
        setupTableView()
        setupCollectionView()
        reservationView.setCornerRadius(color: .black.withAlphaComponent(0.15), shadowRadius: 44, offsetHeight: 4)
        navigationController?.navigationBar.isHidden = true
    }
    
    func gotoItemPage(itemId: Int) {
        let itemVC = UIStoryboard(name: "Item", bundle: .main).instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        itemVC.itemId = itemId
        itemVC.currentReservationId = restuarantViewModel.currentReservationId
        self.present(itemVC, animated: true)
    }
    func getRestuarantData() {
        showLoader()
        restuarantViewModel.getRestuarantData(networkID: networkId!) { [self] result in
            switch result {
            case .success(let restuarantData):
//                branchButton.setTitle(restuarantViewModel.addresses[0].address, for: .normal)
                branchLabel.text = restuarantViewModel.addresses[0].address
                // CHANGE THIS SHIT!!!
                freeTablesLabel.text = "\(1) ազատ սեղան"
                logoImageView.load(str: restuarantData.model.networkLogoUrl)
                cafeNameLabel.text = restuarantData.model.name
                mainCollectionView.reloadData()
                self.hideLoader()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    func createLayout(datesSize: CGFloat) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let determinedSection = Section(rawValue: sectionNum)
            switch determinedSection {
            case .sales:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(285), heightDimension: .estimated(144)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .none, trailing: .fixed(8), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(self.mainCollectionView.frame.width), heightDimension: .estimated(144)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 16
                return section
            case .dates:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(120), heightDimension: .estimated(46)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .none, trailing: .fixed(8), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(101), heightDimension: .absolute(datesSize)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 24
                section.contentInsets.top = 9
                section.contentInsets.leading = 16
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
            case .categories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(80), heightDimension: .estimated(36)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .none, trailing: .fixed(8), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(71), heightDimension: .estimated(36)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 16
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .dishes:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension:.absolute(182))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(self.mainCollectionView.frame.width - 55), heightDimension: .estimated(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                section.contentInsets.bottom = 24
                return section
            case .none:
                return NSCollectionLayoutSection(group: .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
        }
    }
    
    func setupTableView() {
        branchTableView.delegate = self
        branchTableView.dataSource = self
        branchTableView.register(UINib(nibName: "BranchTableViewCell", bundle: .main), forCellReuseIdentifier: "BranchTableViewCell")
    }
    
    func setupCollectionView() {
        mainCollectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DateCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "SaleCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SaleCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "DishCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DishCollectionViewCell")
        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.contentInset.bottom = 10
    }
    
    func reservePressed() {
        let reserveVC = UIStoryboard(name: "Reserve", bundle: .main).instantiateViewController(withIdentifier: "ReserveViewController") as! ReserveViewController
        reserveVC.logoImage = logoImageView.image
        reserveVC.name = cafeNameLabel.text
        reserveVC.networkName = branchLabel.text
        reserveVC.halls = restuarantViewModel.halls
        self.present(reserveVC, animated: true)
    }
    
    @IBAction func branchPressed(_ sender: UITapGestureRecognizer) {
        if isBranchPressed == false {
            UIView.animate(withDuration: 0.5) {
                self.branchTBHeight.constant = 88
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.branchTBHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        isBranchPressed.toggle()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cartPressed(_ sender: UIButton) {
        let cartVC = UIStoryboard(name: "Cart", bundle: .main).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func reservePressed(_ sender: UIButton) {
        reservePressed()
    }
}

extension RestuarantViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return restuarantViewModel.bannerData.count
        case 1:
            return restuarantViewModel.activeReservations.count
        case 2:
            return restuarantViewModel.categories.count
        case 3:
            return restuarantViewModel.dishes.count
        default:
            return -1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .sales:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaleCollectionViewCell", for: indexPath) as! SaleCollectionViewCell
            cell.setupContent(restuarantData: restuarantViewModel.bannerData[indexPath.item], indexPath: indexPath)
            return cell
        case .dates:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
            cell.setupContent(activeReservation: restuarantViewModel.activeReservations[indexPath.item])
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setupContent(category: restuarantViewModel.categories[indexPath.item].name)
            return cell
        case .dishes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCollectionViewCell", for: indexPath) as! DishCollectionViewCell
            cell.setupContent(dishData: restuarantViewModel.dishes[indexPath.item])
            cell.delegate = self
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DishCollectionViewCell {
            print(cell.id)
            gotoItemPage(itemId: cell.id!)
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
            if cell.isSelected {
                cell.dateLabel.textColor = .white
                cell.backgroundColor = UIColor(named: "CustomDarkestGray")
                restuarantViewModel.currentReservationId = cell.id
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            if cell.isSelected {
                cell.categoryName.textColor = .white
                cell.backgroundColor = UIColor(named: "CustomRed")
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
            if !cell.isSelected {
                cell.dateLabel.textColor = .black
                cell.backgroundColor = UIColor(named: "CustomGray")
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            if !cell.isSelected {
                cell.categoryName.textColor = .black
                cell.backgroundColor = UIColor(named: "CustomGray")
            }
        }
    }
}

extension RestuarantViewController: DishCollectionViewCellDelegate {
    func addPressed(id: Int, count: Int, chosenParameters: [String : String]) {
        restuarantViewModel.addItem(item: ItemModel(id: id, count: count, chosenParameters: chosenParameters)) { result in
            switch result {
            case .success():
                print("Added")
            case .failure(_):
                print("Nope!")
            }
        }
    }
}

extension RestuarantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restuarantViewModel.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchTableViewCell", for: indexPath) as! BranchTableViewCell
        cell.addressLabel.text = restuarantViewModel.addresses[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BranchTableViewCell
        UIView.animate(withDuration: 0.5) {
            self.branchTBHeight.constant = 0
            self.view.layoutIfNeeded()
        }
        branchLabel.text = cell.addressLabel.text
        isBranchPressed.toggle()
    }
}

extension RestuarantViewController: ReserveViewControllerDelegate {
    func reloadPage() {
        mainCollectionView.reloadData()
    }
}
