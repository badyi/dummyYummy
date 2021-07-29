//
//  DetailPresenter.swift
//  dummyYummy
//
//  Created by badyi on 05.07.2021.
//

import Foundation

struct ExpandableCharacteristics {
    var isExpanded: Bool = false
    var values: [String] = []
}

final class DetailPresenter {

    weak var view: DetailViewProtocol?

    private var networkService: DetailNetworkServiceProtocol
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol

    private var recipe: Recipe

    private var characteristics: ExpandableCharacteristics

    var navigationDelegate: DetailNavigationDelegate?

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

// MARK: - DetailPresenterProtocol
extension DetailPresenter: DetailPresenterProtocol {
    func checkFavoriteStatus() {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
        if !dataBaseService.recipes(with: predicate).isEmpty {
            recipe.isFavorite = true
            return
        }
        recipe.isFavorite = false
    }

    func prepareIngredientsAndInstructions() {
        if recipe.ingredients == nil || recipe.instructions == nil {
            loadRecipeInfo()
        }
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

        if let servings = recipe.servings {
            characteristics.values.append("Servings: \(servings)")
        }

        boolCharacteristics.forEach { item in
            if item.value {
                characteristics.values.append(item.key)
            }
        }
    }

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
                self?.handleError(error)
            }
        })
    }

    func handleShareTap(at indexPath: IndexPath) {
        guard let url = recipe.sourceURL else {
            return
        }
        navigationDelegate?.share(with: url)
    }

    func segmentDidChange() {
        self.view?.reloadSection(2)
    }

    func getCharacteristics() -> ExpandableCharacteristics {
        return characteristics
    }

    func characteristic(at indexPath: IndexPath) -> String {
        characteristics.values[indexPath.row]
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

    func headerTitle() -> String {
        return recipe.title
    }

    func headerTapped(_ section: Int) {
        if section == 1 {
            characteristics.isExpanded = !characteristics.isExpanded
            view?.reloadSection(section)
        }
    }

    func getRecipe() -> Recipe {
        return recipe
    }

    func handleFavoriteTap(at indexPath: IndexPath) {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))

        if !dataBaseService.recipes(with: predicate).isEmpty {
            deleteFromDB()
            recipe.isFavorite = false
        } else {
            saveToDB()
            recipe.isFavorite = true
        }
        view?.reloadSection(indexPath.section)
    }
}

private extension DetailPresenter {
    func loadRecipeInfo() {
        networkService.loadRecipeInfo(recipe.id, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.recipe.configInfo(with: result)
                self?.recipeInfoDidLoad()
            case .failure(let error):
                self?.handleError(error)
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

extension DetailPresenter {
    private func saveToDB() {
        if let data = recipe.imageData {
            fileSystemService.store(imageData: data, forKey: "\(recipe.id)", completionStatus: { [weak self] status in
                switch status {
                case .success(_):
                    break
                case let .failure(error):
                    self?.handleError(error)
                }
            })
        }

        dataBaseService.update(recipes: [RecipeDTO(with: recipe)])
    }

    private func deleteFromDB() {
        dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])

        if recipe.imageData != nil {
            fileSystemService.delete(forKey: "\(recipe.id)", completionStatus: { [weak self] status in
                switch status {
                case .success(_):
                    break
                case let .failure(error):
                    self?.handleError(error)
                }
            })
        }
    }

    private func handleError(_ error: Error) {
        if let error = error as? ServiceError {
            switch error {
            case .alreadyLoading:
                break
            case .resourceCreatingError:
                NSLog("resource createtion error")
            }
        } else if error.localizedDescription == "cancelled" {

        } else if let error = error as? NetworkHelper.NetworkErrors {
            NSLog(error.localizedDescription)
        } else {
            navigationDelegate?.error(with: error.localizedDescription)
        }
    }
}
