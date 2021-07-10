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
    var currentSelected: Int = 0
    
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: FeedRecipe) {
        self.view = view
        self.recipe = recipe
        self.networkService = networkService
        self.characteristics = ExpandableCharacteristics()
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func characteristic(at indexPath: IndexPath) -> String {
        characteristics.values[indexPath.row]
    }
    
    func currentSelectedSegment() -> Int {
        return currentSelected
    }
    
    func ingredientTitle(at indexPath: IndexPath) -> String {
        guard let ingredient = recipe.ingredients?[indexPath.row] else {
            return ""
        }
        return ingredient
    }
    
    func instructionTitle(at indexPath: IndexPath) -> String {
        guard let instruction = recipe.instructions?[indexPath.row] else {
            return ""
        }
        return instruction
    }
    
    func viewDidLoad() {
        prepareCharacteristics()
        view?.setupView()
    }
    
    func viewWillAppear() {
        view?.configNavigationBar()
    }
    
    func headerTitle() -> String {
        return recipe.title
    }
    
    func headerTapped(_ section: Int) {
        if sections[section] == .characteristics {
            characteristics.isExpanded = !characteristics.isExpanded
            view?.reloadSection(section)
        }
    }
}

extension DetailPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// use footer as small space between sections
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CVFooterView", for: indexPath)
            return footer
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.id, for: indexPath) as! DetailHeader
        header.backgroundColor = .clear

        /// header with image and title
        if sections[indexPath.section] == .headerSection {
            header.configView(with: recipe)
            return header
        /// header with a button to expand
        } else if sections[indexPath.section] == .characteristics {
            header.configViewWith(title: "Characterisctics")
            /// handle the tap  of button
            header.headerTapped = { [weak self] in
                self?.headerTapped(indexPath.section)
            }
        /// header with segment controll
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {
            
            header.configWithSegment(currentSelected)
            header.segmentSelectedValueChanged = { [weak self] value in
                self?.currentSelected = value
                self?.view?.reloadSection(indexPath.section)
            }
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
            /// if the section should not be expanded, return 0
            return 0
        } else if sections[section] == .ingredientsAndInstrusctions {
            if currentSelected == 0 {
                return recipe.ingredients?.count ?? 0
            } else if currentSelected == 1 {
                return recipe.instructions?.count ?? 0
            }
        }
        return 0
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as! DetailCell
        
        /// configuring cells for characteristics section
        if sections[indexPath.section] == .characteristics {
            cell.config(with: characteristics.values[indexPath.row])
            return cell
        /// configuring cells for ingredients and instructions section
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {
            /// configuring for ingredients
            if currentSelected == 0 {
                cell.config(with: recipe.ingredients?[indexPath.row] ?? "")
            /// configuring for instructions
            } else if currentSelected == 1 {
                cell.config("Step \(indexPath.row + 1). ",with: recipe.instructions?[indexPath.row] ?? "")
            }
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
    
    func prepareIngredients() {
//        guard let ingredients = recipe.ingredients else {
//            #warning("load")
//            return
//        }
    }
}
