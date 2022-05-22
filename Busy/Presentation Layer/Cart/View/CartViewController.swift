//
//  CartViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 04.02.22.
//

import UIKit

class CartViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case categories
        case dates
        case dishes
    }
    @IBOutlet weak var mainCollectionView: UICollectionView!
    let cartViewModel = CartViewModel()
    var cartId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        getCartData()
        setupCollectionView()
    }
    
    func getCartData() {
        cartViewModel.getCartData { result in
            switch result {
            case .success():
                self.mainCollectionView.reloadData()
            case .failure(_):
                print("No")
            }
        }
    }
    
    func setupCollectionView() {
        mainCollectionView.collectionViewLayout = createLayout(footerHeight: 332)
        mainCollectionView.register(UINib(nibName: "OrderNetworkCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OrderNetworkCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "OrderDateCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OrderDateCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "OrderDishCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OrderDishCollectionViewCell")
        mainCollectionView.register(OrderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: OrderFooterView.reuseId)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.contentInset.top = 24
    }
    
    func createLayout(footerHeight: CGFloat) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let determinedSection = Section(rawValue: sectionNum)
            switch determinedSection {
            case .categories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(163), heightDimension: .estimated(56)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(24), top: .none, trailing: .fixed(12), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(163), heightDimension: .estimated(56)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 16
                return section
            case .dates:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(101), heightDimension: .estimated(36)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(24), top: .none, trailing: .fixed(12), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(101), heightDimension: .estimated(36)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 24
                return section
            case .dishes:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(self.view.frame.width - 24), heightDimension: .estimated(110)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(24), top: .none, trailing: .fixed(16), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(self.view.frame.width - 24), heightDimension: .estimated(110)), subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(footerHeight)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            case .none:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: .init(widthDimension: .estimated(-1), heightDimension: .estimated(-1))))
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cartViewModel.networks.count
        case 1:
            return cartViewModel.reservationDates.count
        case 2:
            return cartViewModel.items.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderNetworkCollectionViewCell", for: indexPath) as! OrderNetworkCollectionViewCell
            cell.setupContent(network: cartViewModel.networks[indexPath.item])
            return cell
        case .dates:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderDateCollectionViewCell", for: indexPath) as! OrderDateCollectionViewCell
            cell.setupContent(reservation: cartViewModel.reservationDates[indexPath.item])
            return cell
        case .dishes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderDishCollectionViewCell", for: indexPath) as! OrderDishCollectionViewCell
            cell.setupContent(item: cartViewModel.items[indexPath.item])
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .categories:
            return CGSize(width: 163, height: 56)
        case .dates:
            return CGSize(width: 101, height: 36)
        case .dishes:
            return CGSize(width: view.frame.width - 24, height: 110)
        case .none:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 2 {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OrderFooterView.reuseId, for: indexPath) as! OrderFooterView
            footer.delegate = self
            footer.setupFeeLabels(percent: 10, fee: 5000, wholePrice: 8000, receivableCoins: 11, availabelCoins: 69)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? OrderDateCollectionViewCell {
            cartId = cell.id
            
        }
    }
}

extension CartViewController: OrderFooterViewDelegate {
    func orderPressed() {
        cartViewModel.placeOrder(cartId: cartId ?? 16) { result in
            switch result {
            case .success():
                print("Order placed")
            case .failure(_):
                print("Nope!!")
            }
        }
    }
    
    func addNewCard() {
        mainCollectionView.collectionViewLayout = createLayout(footerHeight: 1000)
    }
    
    func offlinePressed() {
        mainCollectionView.collectionViewLayout = createLayout(footerHeight: 332)
    }
    
    func onlinePressed() {
        mainCollectionView.collectionViewLayout = createLayout(footerHeight: 524)
    }
}
