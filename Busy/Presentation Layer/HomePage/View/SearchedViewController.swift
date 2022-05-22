//
//  SearchedViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 18.05.22.
//

import UIKit

protocol SearchedViewControllerDelegate: AnyObject {
    func goToRestuarant(_ cellId: Int)
}

class SearchedViewController: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let homePageViewModel = HomePageViewModel()
    weak var delegate: SearchedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupCollectionView()
    }
    
    func setupTextField() {
        searchTF.setupLeftView()
        searchTF.delegate = self
        searchTF.becomeFirstResponder()
    }
    
    func setupCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "RestuarantCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RestuarantCollectionViewCell")
        mainCollectionView.collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension:.absolute(126))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.mainCollectionView.frame.width - 55), heightDimension: .estimated(126))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.trailing = 16
            section.contentInsets.bottom = 24
            return section
        }
    }
    func goToRestuarantPage(_ id: Int) {
        let restuarantVC = UIStoryboard(name: "Cafe", bundle: .main).instantiateViewController(withIdentifier: "RestuarantViewController") as! RestuarantViewController
        restuarantVC.networkId = id
        navigationController?.pushViewController(restuarantVC, animated: true)
    }
}

extension SearchedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.isEmpty {
            self.dismiss(animated: true)
        } else {
            homePageViewModel.search(text: textField.text!) { result in
                switch result {
                case .success():
                    self.mainCollectionView.reloadData()
                case .failure(_):
                    print("search failed!")
                }
            }
        }
    }
}

extension SearchedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePageViewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
        if homePageViewModel.searchResults.isEmpty {
            return cell
        }
        cell.setContent(restuarant: homePageViewModel.searchResults[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = mainCollectionView.cellForItem(at: indexPath) as! RestuarantCollectionViewCell
        delegate!.goToRestuarant(cell.id!)
        self.dismiss(animated: true)
    }
}
