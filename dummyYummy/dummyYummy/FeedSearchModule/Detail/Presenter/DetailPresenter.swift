//
//  DetailPresenter.swift
//  dummyYummy
//
//  Created by badyi on 05.07.2021.
//

import UIKit

enum DetailSections {
    case headerSection, characteristics, ingredientsAndInstrusctions
}

struct ExpandableCharacteristics {
    var isExpanded: Bool = false
    var values: [String] = []
}

final class DetailPresenter: NSObject {

    weak var view: DetailViewProtocol?
    var networkService: DetailNetworkServiceProtocol
    var recipe: FeedRecipe
    let sections: [DetailSections] = [.headerSection, .characteristics, .ingredientsAndInstrusctions]
    
    var characteristics: ExpandableCharacteristics
    
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: FeedRecipe) {
        self.view = view
        self.recipe = recipe
        self.networkService = networkService
        self.characteristics = ExpandableCharacteristics()
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        prepareCharacteristics()
    }
    
    func viewWillAppear() {
        
    }
    
    func headerTitle() -> String {
        return recipe.title
    }
    
    func headerTapped(_ section: Int) {
        if sections[section] == .characteristics {
            characteristics.isExpanded = !characteristics.isExpanded
            view?.reloadSection(section
            )
        }
    }
}

extension DetailPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CVReusableView", for: indexPath)
            return footer
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.id, for: indexPath) as! DetailHeader
        
        if sections[indexPath.section] == .headerSection {
            header.configView(with: recipe)
            header.backgroundColor = .systemGreen
            return header
        } else if sections[indexPath.section] == .characteristics {
            header.configViewWith(title: "Characterisctics")
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {
            header.configWithSegment()
        }
        
        header.headerTapped = { [weak self] in
            self?.headerTapped(indexPath.section)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sections[section] == .headerSection {
            return 0
        } else if sections[section] == .characteristics {
            if characteristics.isExpanded {
                return characteristics.values.count
            }
            return 0
        } else if sections[section] == .ingredientsAndInstrusctions {
            
        }
        return 0
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if sections[indexPath.section] == .characteristics {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacteristicsCell.id, for: indexPath) as! CharacteristicsCell
            cell.config(with: characteristics.values[indexPath.row])
            return cell
        }
        return cell
    }
}

private extension DetailPresenter {
    func prepareCharacteristics() {
        guard let boolCharacteristics = recipe.boolCharacteristics else {
            #warning("load")
            return
        }
        
        if let healthScore = recipe.healthScore {
            characteristics.values.append("Health score: \(healthScore)")
        }
        if let readyInMinutes = recipe.readyInMinutes {
            characteristics.values.append("Ready in minutes:  \(readyInMinutes)")
        }
        boolCharacteristics.forEach { i in
            if i.value {
                characteristics.values.append(i.key)
            }
        }
    }
}
