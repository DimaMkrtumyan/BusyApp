//
//  AllNetworksViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 07.04.22.
//

import UIKit

class AllNetworksViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case stories
        case types
        case networks
    }
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let allViewModel = AllNetworksViewModel()
    var type: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCollectionView()
    }
    
    func getData() {
        showLoader()
        allViewModel.getAllNetworks(type: type!) { result in
            switch result {
            case .success():
                self.mainCollectionView.reloadData()
                self.hideLoader()
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    func setupCollectionView() {
        mainCollectionView.collectionViewLayout = createLayout()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "StoryCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "TypeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TypeCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "RestuarantCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RestuarantCollectionViewCell")
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId)
        mainCollectionView.contentInset.top = 10
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let determinedSection = Section(rawValue: sectionNum)
            switch determinedSection {
            case .stories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(118), heightDimension: .absolute(184)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(4), top: .fixed(12), trailing: .fixed(4), bottom: .none)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(self.mainCollectionView.frame.width), heightDimension: .absolute(184)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 18
                section.contentInsets.trailing = 20
                section.contentInsets.bottom = 28
                return section
            case .types:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(120), heightDimension: .absolute(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(12), top: .none, trailing: .none, bottom: .none)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(self.mainCollectionView.frame.width), heightDimension: .estimated(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 5
                section.contentInsets.trailing = 18
                section.contentInsets.bottom = 17
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
            case .networks:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(126))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.mainCollectionView.frame.width - 55), heightDimension: .estimated(126))
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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AllNetworksViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .stories:
            return allViewModel.stories.count
        case .types:
            return allViewModel.categories.count
        case .networks:
            return allViewModel.networks.count
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .stories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            cell.setContentForAll(story: allViewModel.stories[indexPath.item])
            return cell
        case .types:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
            cell.setupContentForAll(type: allViewModel.categories[indexPath.item])
            return cell
        case .networks:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestuarantCollectionViewCell", for: indexPath) as! RestuarantCollectionViewCell
            cell.setContentForAll(restuarant: allViewModel.networks[indexPath.item])
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as! HeaderView
            header.categoryLabel.text = "Սրճարաններ"
            header.allButton.isHidden = true
            return header
        }
        return UICollectionReusableView()
    }
}
