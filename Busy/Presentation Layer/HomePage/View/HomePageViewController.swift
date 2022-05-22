//
//  HomePageViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import UIKit

class HomePageViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case stories
        case cafes
        case fastFoodRestuarants
        case resturarants
    }

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var categoryColletionView: UICollectionView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let homePageViewModel = HomePageViewModel()
    var headerTitles = ["Սրճարաններ", "Արագ Սնունդ", "Ռեստորաններ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        fetchData()
        setupCollectionView()
        setupMainCollectionView()
    }
    
    func fetchData() {
        showLoader()
        homePageViewModel.getMainPageData { result in
            switch result {
            case .success(_):
                self.hideLoader()
                self.categoryColletionView.reloadData()
                self.mainCollectionView.reloadData()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    func goToRestuarant(_ id: Int) {
        let restuarantVC = UIStoryboard(name: "Cafe", bundle: .main).instantiateViewController(withIdentifier: "RestuarantViewController") as! RestuarantViewController
        restuarantVC.networkId = id
        navigationController?.pushViewController(restuarantVC, animated: true)
    }
    
    func gotoAllPage(type: Int) {
        let allVC = UIStoryboard(name: "AllNetworks", bundle: .main).instantiateViewController(withIdentifier: "AllNetworksViewController") as! AllNetworksViewController
        allVC.type = type
        navigationController?.pushViewController(allVC, animated: true)
    }
    
    func setupCollectionView() {
        categoryColletionView.delegate = self
        categoryColletionView.dataSource = self
        categoryColletionView.register(UINib(nibName: "TypeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TypeCollectionViewCell")
        categoryColletionView.contentInset.left = 24
        categoryColletionView.contentInset.right = 24
    }
    
    func setupMainCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "StoryCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "RestuarantCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RestuarantCollectionViewCell")
        mainCollectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.reuseId)
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId)
        mainCollectionView.collectionViewLayout = createLayout()
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let determinedSection = Section(rawValue: sectionNum)
            switch determinedSection {
            case .stories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(118), heightDimension: .absolute(184)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(self.view.frame.width), heightDimension: .absolute(184)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                section.contentInsets.bottom = 44
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(150)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            case .cafes, .fastFoodRestuarants, .resturarants:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension:.absolute(126))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.mainCollectionView.frame.width - 55), heightDimension: .estimated(126))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                section.contentInsets.bottom = 24
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
            case .none:
                return NSCollectionLayoutSection(group: .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
        }
    }
    
    func determineCells(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .stories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            cell.setContent(story: homePageViewModel.stories[indexPath.item])
            return cell
        case .cafes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
            cell.setContent(restuarant: homePageViewModel.cafes[indexPath.item])
            return cell
        case .fastFoodRestuarants:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
            cell.setContent(restuarant: homePageViewModel.fastFood[indexPath.item])
            return cell
        case .resturarants:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
            cell.setContent(restuarant: homePageViewModel.restuarants[indexPath.item])
            return cell
//        case .searchResults:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
//            cell.setContent(restuarant: homePageViewModel.searchResults[indexPath.item])
//            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        let cartVC = UIStoryboard(name: "Cart", bundle: .main).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func bellPressed(_ sender: UIButton) {
        let ntfVC = UIStoryboard(name: "Notifications", bundle: .main).instantiateViewController(withIdentifier: "NotificationsViewController")
        navigationController?.pushViewController(ntfVC, animated: true)
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryColletionView {
            return 1
        }
        return homePageViewModel.sections.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColletionView {
            return homePageViewModel.sections.count
        } else {
            switch section {
            case 0:
                return homePageViewModel.stories.count
            case 1...3:
                return homePageViewModel.restuarants.count
            default:
                return -1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryColletionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
            cell.setupContent(type: homePageViewModel.sections[indexPath.item])
            return cell
        case mainCollectionView:
            return determineCells(collectionView, indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == mainCollectionView {
            switch indexPath.section {
                   case 0:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.reuseId, for: indexPath) as! FooterView
                footer.setupViews(homePageViewModel.activeOrderCount)
                footer.delegate = self
                return footer
            case 1...3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as! HeaderView
                header.delegate = self
//                print(homePageViewModel.sections[indexPath.section].typeName)
                header.categoryLabel.text = homePageViewModel.sections[indexPath.section - 1].typeName
                header.type = indexPath.section - 1

                return header
            default:
                return UICollectionReusableView()
            }
        }
       return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryColletionView {
            let cell = categoryColletionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
            cell.select(label: cell.categoryNameLabel, logo: cell.categoryImageView)
            mainCollectionView.scrollToItem(at: IndexPath(row: 0, section: indexPath.row + 1), at: .init(rawValue: 10), animated: true)
        } else {
            if let cell = mainCollectionView.cellForItem(at: indexPath) as? RestuarantCollectionViewCell {
                print(cell.id)
                goToRestuarant(cell.id!)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryColletionView {
            let cell = collectionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
            cell.deselect(label: cell.categoryNameLabel, logo: cell.categoryImageView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryColletionView {
            return CGSize(width: 180, height: 50)
        } else {
            let section = Section(rawValue: indexPath.section)
            switch section {
            case .stories:
                return CGSize(width: 118, height: 184)
            case .cafes, .fastFoodRestuarants, .resturarants:
                return CGSize(width: 160, height: 126)
            case .none:
                return CGSize()
            }
        }
    }
}

extension HomePageViewController: HeaderViewDelegate {
    func allPressed(type: Int) {
        gotoAllPage(type: type)
    }
}

extension HomePageViewController: FooterViewDeleage {
    func activeOrdersPressed() {
        let activeOrdersVC = UIStoryboard(name: "ActiveOrders", bundle: .main).instantiateViewController(withIdentifier: "ActiveOrdersViewController")
        navigationController?.pushViewController(activeOrdersVC, animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textfield: UITextField) {
        textfield.resignFirstResponder()
        let searchedVC = UIStoryboard(name: "Searched", bundle: .main).instantiateViewController(withIdentifier: "SearchedViewController") as! SearchedViewController
        searchedVC.delegate = self
        self.present(searchedVC, animated: true)
    }
}

extension HomePageViewController: SearchedViewControllerDelegate {
    func goToRestuarantPage(_ cellId: Int) {
        goToRestuarant(cellId)
    }
}
