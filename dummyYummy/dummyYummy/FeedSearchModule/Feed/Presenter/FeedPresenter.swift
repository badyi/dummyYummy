//
//  FeedPresenter.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import Foundation

final class FeedPresenter {

    weak var view: FeedViewProtocol?
    private var networkService: FeedServiceProtocol
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol

    weak var navigationDelegate: RecipesNavigationDelegate?

    var recipes: [Recipe]
    private let randomRecipesCount: Int = 100

    init(with view: FeedViewProtocol,
         _ networkService: FeedServiceProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol) {

        self.view = view
        self.networkService = networkService
        self.dataBaseService = dataBaseService
        self.fileSystemService = fileSystemService
        recipes = []
    }
}

// MARK: - FeedPresenterProtocol
extension FeedPresenter: FeedPresenterProtocol {

    func recipesCount() -> Int {
        recipes.count
    }

    func recipeTitle(at index: Int) -> String? {
        if index < 0 || index >= recipes.count {
            return nil
        }
        return recipes[index].title
    }

    func willDisplayRecipe(at index: Int) {
        if index < 0 || index >= recipes.count {
            return
        }
        loadImageIfNeeded(at: index)
    }

    func didEndDisplayingRecipe(at index: Int) {
        guard let imageURL = recipe(at: index)?.imageURL else { return }
        self.cancelLoad(with: imageURL)
    }

    func didSelectRecipe(at index: Int) {
        guard let recipe = recipe(at: index) else {
            return
        }
        navigationDelegate?.didTapRecipe(recipe)
    }

    func recipe(at index: Int) -> Recipe? {
        if index < 0 || index >= recipes.count {
            return nil
        }

        return recipes[index]
    }

    func handleFavoriteTap(at index: Int) {
        guard let recipe = recipe(at: index) else {
            return
        }
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))

        if !dataBaseService.recipes(with: predicate).isEmpty {
            deleteFromDB(at: index)
        } else {
            saveToDB(at: index)
        }
        view?.reloadItems(at: [IndexPath(row: index, section: 0)])
    }

    func checkFavoriteStatus(at index: Int) -> Bool {
        guard let recipe = recipe(at: index) else {
            return false
        }
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
        if !dataBaseService.recipes(with: predicate).isEmpty {
            return true
        }
        return false
    }

    func loadRandomRecipes() {
        networkService.clearAndCancelAll()
        networkService.loadRandomRecipes(randomRecipesCount, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.recipes.map { Recipe(with: $0) }
                self?.recipesDidLoad()
            case let .failure(error):
                self?.handleError(error)
            }
        })
    }

    func loadRandomRecipesIfNeeded() {
        if recipes.isEmpty {
            loadRandomRecipes()
        }
    }
}

extension FeedPresenter {
    private func saveToDB(at index: Int) {
        let recipe = recipes[index]
        recipe.isFavorite = true

        if let data = recipe.imageData {
            fileSystemService.store(imageData: data, forKey: "\(recipe.id)", completionStatus: { [weak self] status in
                switch status {
                case let .failure(error):
                    self?.handleError(error)
                default: break
                }
            })
        }
        dataBaseService.update(recipes: [RecipeDTO(with: recipe)])
    }

    private func deleteFromDB(at index: Int) {
        let recipe = recipes[index]
        recipe.isFavorite = false

        dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])

        if recipe.imageData != nil {
            fileSystemService.delete(forKey: "\(recipe.id)", completionStatus: { status in
                switch status {
                case let .failure(error):
                    NSLog("\(error.localizedDescription)")
                default: break
                }
            })
        }
        return
    }

    private func recipesDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollectionView()
        }
    }

    private func imageDidLoad(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }

    private func loadImageIfNeeded(at index: Int) {
        if recipes[index].imageData != nil {
            return
        }
        guard let url = recipes[index].imageURL else {
            return
        }
        networkService.loadImage(with: url, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.setImageData(at: index, result)
                self?.imageDidLoad(at: index)
            case let .failure(error):
                self?.handleError(error)
            }
        })
    }

    private func cancelLoad(with url: String) {
        networkService.cancelImageLoad(with: url)
    }

    private func setImageData(at index: Int, _ data: Data) {
        recipes[index].imageData = data
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
            // ok scenario. do nothing
        } else {
            navigationDelegate?.showErrorAlert(with: error.localizedDescription)
        }
    }

}
