//
//  FavRestuarantViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 13.01.22.
//

import UIKit

class FavRestuarantViewController: UIViewController {
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    let favouritesViewModel = FavouritesViewModel()
    var id: Int?
    var titleName = ""
    let userId = StorageManager().getUserId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavouriteDishes(networkId: id!)
        setupCollectionView()
        navigationController?.navigationBar.isHidden = true
    }
    
    func getFavouriteDishes(networkId: Int) {
        favouritesViewModel.getFavouriteDishes(networkId: networkId) { result in
            switch result {
            case .success(let branch):
                print(branch)
                self.favCollectionView.reloadData()
            case .failure(_):
                print("Nope!")
            }
        }
    }
    
    func setupCollectionView() {
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
        favCollectionView.register(UINib(nibName: "FavDishCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavDishCollectionViewCell")
        favCollectionView.register(FavHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FavHeaderView")
        favCollectionView.contentInset = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
    }
    
    func goToRestuarantPage(_ id: Int) {
        let restuarantVC = UIStoryboard(name: "Cafe", bundle: .main).instantiateViewController(withIdentifier: "RestuarantViewController") as! RestuarantViewController
        restuarantVC.networkId = id
        navigationController?.pushViewController(restuarantVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension FavRestuarantViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesViewModel.favouriteDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavDishCollectionViewCell", for: indexPath) as! FavDishCollectionViewCell
        cell.setupContent(favItem: favouritesViewModel.favouriteDishes[indexPath.item])
        cell.id = favouritesViewModel.favouriteDishes[indexPath.item].id
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 56) / 2, height: 182)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FavHeaderView", for: indexPath) as! FavHeaderView
        header.delegate = self
        header.setupContent(titleName, favouritesViewModel.favDishBranches.first?.address ?? "")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: favCollectionView.frame.width, height: 102)
    }
}

extension FavRestuarantViewController: OpenPageTappedDelegate {
    func buttonTapped() {
        goToRestuarantPage(id!)
    }
}
