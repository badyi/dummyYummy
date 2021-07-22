//
//  SearchPresenter.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import Foundation

final class SearchPresenter: NSObject {
    weak var view: SearchViewProtocol?
    private var service: SearchNetworkServiceProtocol
    public private(set) var refinements: SearchRefinements

    weak var navigationDelegate: SearchNavigationDelegate?

    var recipes: [Recipe]

    init(with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol) {
        self.service = networkService
        self.view = view
        refinements = SearchRefinements()
        recipes = []
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func recipe(at index: Int) -> Recipe? {
        if index < 0 || index >= recipes.count {
            return nil
        }

        return recipes[index]
    }

    func recipesCount() -> Int {
        return recipes.count
    }

    func searchRefinementsTapped() {
        navigationDelegate?.didTapSearchSettingsButton(refinements)
    }

    func resultCount() -> Int {
        recipes.count
    }

    func willDisplayRecipe(at index: Int) {
        loadImageIfNeeded(for: recipes[index], at: index)
    }

    func didEndDisplayRecipe(at index: Int) {
        guard let url = recipe(at: index)?.imageURL else { return }
        service.cancelImageLoad(with: url)
    }

    func didSelectRecipe(at index: Int) {
        navigationDelegate?.didTapRecipe(recipes[index])
    }

    func updateRefinements(_ refinements: SearchRefinements) {
        self.refinements = refinements
    }

    func loadRecipes(with query: String) {
        service.cancelCurrenSearch()
        service.cancelLoadAllImages()

        recipes = []
        view?.reloadCollectionView()

        service.loadSearch(query) { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.results.map {
                    Recipe(with: $0)
                }
                self?.reloadCollection()
            case let .failure(error):
                self?.handleError(error)
            }
        }
    }
}

private extension SearchPresenter {
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollectionView()
        }
    }
}

extension SearchPresenter {

    private func loadImageIfNeeded(for recipe: Recipe, at index: Int) {
        guard let imageURL = recipe.imageURL, recipe.imageData == nil else {
            return
        }
        service.loadImage(with: imageURL, completion: {
            [weak self] result in
                switch result {
                case let .success(result):
                    self?.setImageData(at: index, result)
                    self?.imageDidLoad(at: index)
                case let .failure(error):
                    self?.handleError(error)
                }
        })
    }

    private func setImageData(at index: Int, _ data: Data) {
        guard let recipe = recipe(at: index) else { return }

        recipe.imageData = data
    }

    private func imageDidLoad(at index: Int) {
        guard recipe(at: index) != nil else { return }

        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [IndexPath(row: index, section: 0)])
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
            // ok scenario. do nothing
        } else {
            navigationDelegate?.showErrorAlert(with: error.localizedDescription)
        }
    }
}
