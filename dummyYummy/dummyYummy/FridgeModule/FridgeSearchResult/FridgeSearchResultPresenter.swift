//
//  FridgeSearchResultPresenter.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol FridgeSearchResultPresenterProtocol {

    init(with view: FridgeSearchResultViewProtocol,
         _ networkService: FridgeSearchNetworkServiceProtocol,
         _ ingredients: [String])

    func didSelectRecipe(at index: Int)
    func loadImageIfNeeded(at index: Int)
    func cancelLoadImageIfNeeded(at index: Int)
    func recipe(at index: Int) -> Recipe?
    func recipesCount() -> Int
    func loadRecipes()
}

final class FridgeSearchResultPresenter {
    weak var view: FridgeSearchResultViewProtocol?
    var networkService: FridgeSearchNetworkServiceProtocol
    var recipes: [Recipe]
    var ingredients: [String]

    var navigationDelegate: RecipesViewNavigationDelegate?

    init(with view: FridgeSearchResultViewProtocol,
         _ networkService: FridgeSearchNetworkServiceProtocol,
         _ ingredients: [String]) {
        self.ingredients = ingredients
        recipes = []
        self.view = view
        self.networkService = networkService
    }
}

extension FridgeSearchResultPresenter: FridgeSearchResultPresenterProtocol {
    func didSelectRecipe(at index: Int) {
        guard let recipe = recipe(at: index) else {
            return
        }
        navigationDelegate?.didTapRecipe(recipe)
    }

    func loadImageIfNeeded(at index: Int) {
        guard let imageURL = recipe(at: index)?.imageURL else {
            return
        }
        if recipe(at: index)?.imageData != nil {
            return
        }
        networkService.loadImage(with: imageURL, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.setImageData(at: index, result)
                self?.reloadRecipe(at: index)
            case let .failure(error):
                self?.handleError(error)
            }
        })
    }

    func cancelLoadImageIfNeeded(at index: Int) {

    }

    func recipe(at index: Int) -> Recipe? {
        if index < 0 || index >= recipes.count {
            return nil
        }

        return recipes[index]
    }

    func recipesCount() -> Int {
        recipes.count
    }

    func loadRecipes() {
        networkService.loadRecipes(ingredients, 10, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.map { Recipe(with: $0) }
                self?.reloadCollection()
            case let .failure(error):
                self?.handleError(error)
            }
        })
    }
}

extension FridgeSearchResultPresenter {
    private func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollectionView()
        }
    }

    private func reloadRecipe(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }

    private func setImageData(at index: Int, _ data: Data) {
        recipe(at: index)?.imageData = data
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
        } else if let error = error as? NetworkHelper.NetworkErrors {
            switch error {
            case .noConnection:
                navigationDelegate?.error(with: "No connection")
            }
        } else {
            navigationDelegate?.error(with: error.localizedDescription)
        }
    }
}
