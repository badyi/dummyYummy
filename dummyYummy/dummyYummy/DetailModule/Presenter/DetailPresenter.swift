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

    private var networkService: DetailNetworkServiceProtocol
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol

    private var recipe: Recipe
    private let sections: [DetailSections] = [.headerSection, .characteristics, .ingredientsAndInstrusctions]

    var characteristics: ExpandableCharacteristics
    var currentSelected: Int = 0

    init(with view: DetailViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol,
         _ networkService: DetailNetworkServiceProtocol,
         _ recipe: Recipe) {

        self.view = view
        self.recipe = recipe
        self.networkService = networkService
        self.characteristics = ExpandableCharacteristics()
        self.fileSystemService = fileSystemService
        self.dataBaseService = dataBaseService
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
        loadImageIfNeeded()
        prepareCharacteristics()
        prepareIngredientsAndInstructions()
        recipe.isFavorite = checkFavoriteStatus()
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

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        // use footer as small space between sections
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "CVFooterView",
                                                                         for: indexPath)
            return footer
        }
        #warning("default header")
        let headerKind = UICollectionView.elementKindSectionHeader
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind,
                                                                           withReuseIdentifier: DetailHeader.id,
                                                                           for: indexPath) as? DetailHeader else {
            return UICollectionReusableView()
        }
        header.backgroundColor = .clear

        // header with image and title
        if sections[indexPath.section] == .headerSection {

            recipe.isFavorite = checkFavoriteStatus()
            header.configView(with: recipe)

            header.handleFavoriteButtonTap = { [weak self] in
                self?.handleFavoriteTap()
                self?.view?.reloadSection(indexPath.section)
            }
            return header

        // header with a button to expand
        } else if sections[indexPath.section] == .characteristics {

            header.configViewWith(title: "Characterisctics")
            // handle the tap  of button
            header.isExpanded = characteristics.isExpanded
            header.headerTapped = { [weak self] in
                self?.headerTapped(indexPath.section)
            }

        // header with segment controll
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
            // if the section should not be expanded, return 0
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

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        #warning("default cell")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id,
                                                            for: indexPath) as? DetailCell else {
            return UICollectionViewCell()
        }

        // configuring cells for characteristics section
        if sections[indexPath.section] == .characteristics {
            cell.config(with: characteristics.values[indexPath.row])
            return cell
        // configuring cells for ingredients and instructions section
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {
            // configuring for ingredients
            if currentSelected == 0 {
                cell.config(with: recipe.ingredients?[indexPath.row] ?? "")
            // configuring for instructions
            } else if currentSelected == 1 {
                cell.config("Step \(indexPath.row + 1). ", with: recipe.instructions?[indexPath.row] ?? "")
            }
        }
        return cell
    }
}

private extension DetailPresenter {
    func loadImageIfNeeded() {
        if recipe.imageData != nil {
            return
        }
        guard let url = recipe.imageURL else {
            return
        }
        networkService.loadImage(url, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipe.imageData = result
                self?.imageDidLoad()
            case let .failure(error):
                print(error.localizedDescription)
            }

        })
    }

    func prepareCharacteristics() {
        guard let boolCharacteristics = recipe.boolCharacteristics else {
            loadRecipeInfo()
            return
        }

        if let healthScore = recipe.healthScore {
            characteristics.values.append("Health score: \(healthScore)")
        }
        if let readyInMinutes = recipe.readyInMinutes {
            characteristics.values.append("Ready in minutes:  \(readyInMinutes)")
        }
        boolCharacteristics.forEach { item in
            if item.value {
                characteristics.values.append(item.key)
            }
        }
    }

    func prepareIngredientsAndInstructions() {
        if recipe.ingredients == nil || recipe.instructions == nil {
            loadRecipeInfo()
        }
    }

    func loadRecipeInfo() {
        networkService.loadRecipeInfo(recipe.id, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.recipe = Recipe(with: result)
                self?.recipeInfoDidLoad()
            case .failure(let error):
                #warning("alert")
                print(error)
            }
        })
    }

    func recipeInfoDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareCharacteristics()
            self?.prepareIngredientsAndInstructions()
            self?.view?.reloadCollection()
        }
    }

    func imageDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollection()
        }
    }
}

private extension DetailPresenter {
    func handleFavoriteTap() {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))

        if !dataBaseService.recipes(with: predicate).isEmpty {
            dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])
            if recipe.imageData != nil {
                fileSystemService.delete(forKey: "\(recipe.id)", completionStatus: { status in
                    switch status {
                    case let .success(status):
                        print(status)
                    case let .failure(error):
                        #warning("hadnle error")
                        print(error)
                    }
                })
            }
            return
        }

        if let data = recipe.imageData {
            fileSystemService.store(imageData: data, forKey: "\(recipe.id)", completionStatus: { status in
                switch status {
                case let .success(status):
                    print(status)
                case let .failure(error):
                    #warning("hadnle error")
                    print(error.localizedDescription)
                }
            })
        }
        dataBaseService.update(recipes: [RecipeDTO(with: recipe)])
    }

    func checkFavoriteStatus() -> Bool {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
        if !dataBaseService.recipes(with: predicate).isEmpty {
            return true
        }
        return false
    }
}
