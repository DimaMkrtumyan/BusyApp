//
//  ItemViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 08.02.22.
//

import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func addPressed(logoName: String, name: String, networkName: String)
}

class ItemViewController: UIViewController {
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    weak var delegate: ItemViewControllerDelegate?
    var currentReservationId: Int?
    var itemId: Int?
    let itemViewModel = ItemViewModel()
    let restuarantViewModel = RestuarantViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        restuarantViewModel.currentReservationId = currentReservationId
        getItemData()
        setupCollectionView()
    }
    
    func getItemData() {
        itemViewModel.getItem(itemId: itemId!) { result in
            switch result {
            case .success(_):
                self.itemCollectionView.reloadData()
            case .failure(_):
                print("Nope!!!")
            }
        }
    }
    
    func setupCollectionView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "ItemOptionsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ItemOptionsCollectionViewCell")
        itemCollectionView.register(ItemMainHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemMainHeader.reuseId)
        itemCollectionView.register(ItemParameterHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemParameterHeader.reuseId)
        itemCollectionView.register(ItemFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ItemFooter.reuseId)
        itemCollectionView.contentInset.bottom = 10
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
//        delegate?.addPressed(logoName: itemViewModel.itemData!.logoUrl, name: itemViewModel.itemData!.name, networkName: itemViewModel.itemData!.networkName)
        restuarantViewModel.addItem(item: ItemModel(id: itemId!, count: 0, chosenParameters: [:])) { result in
            switch result {
            case .success():
                self.dismiss(animated: true, completion: nil)
            case .failure(_):
                print("Could not add")
            }
        }
    }
}

extension ItemViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemViewModel.parameters.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemViewModel.parameters[section].variants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemOptionsCollectionViewCell", for: indexPath) as! ItemOptionsCollectionViewCell
        cell.setupContent(item: itemViewModel.parameters[indexPath.item].variants[indexPath.item], itemData: itemViewModel.itemData!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = itemCollectionView.cellForItem(at: indexPath) as! ItemOptionsCollectionViewCell
        cell.isVariantSelected = true
        cell.selectItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = itemCollectionView.cellForItem(at: indexPath) as! ItemOptionsCollectionViewCell
        cell.isVariantSelected = false
        cell.selectItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemMainHeader.reuseId, for: indexPath) as! ItemMainHeader
            header.setupContent(mainImageName: itemViewModel.itemData!.imageUrl, logoImageName: itemViewModel.itemData!.logoUrl, networkName: itemViewModel.itemData!.networkName, dishName: itemViewModel.itemData!.name, detailsName: itemViewModel.itemData!.ingridients, discountedPrice: itemViewModel.itemData!.discountedPrice, price: itemViewModel.itemData!.price, parameter: itemViewModel.parameters[indexPath.section].name)
            return header
        } else {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemParameterHeader.reuseId, for: indexPath) as! ItemParameterHeader
                header.setupContent(parameter: itemViewModel.parameters[indexPath.section].name)
                return header
                //                    case UICollectionView.elementKindSectionFooter:
                //                        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemFooter.reuseId, for: indexPath)
                //                        return footer
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 89, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 530)
        } else {
            return CGSize(width: view.frame.width, height: 37)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 80)
//    }
}
