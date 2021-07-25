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

    weak var navigationDelegate: SearchNavigationDelegate?

    var recipes: [Recipe]
    var searchText: String

    init(with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol) {
        self.service = networkService
        self.view = view
        searchText = ""
        recipes = []
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func updateSearchText(_ query: String) {
        if query != searchText {
            service.cancelCurrenSearch()
            service.cancelLoadAllImages()

            recipes = []
            view?.reloadCollectionView()
        }
        searchText = query
    }

    func recipe(at index: Int) -> Recipe? {
        if index < 0 || index >= recipes.count {
            return nil
        }

        return recipes[index]
    }

    func recipesCount() -> Int {
        return recipes.count
    }

    func resultCount() -> Int {
        recipes.count
    }

    func willDisplayRecipe(at index: Int) {
        if let recipe = recipe(at: index) {
            loadImageIfNeeded(for: recipe, at: index)
        }
    }

    func didEndDisplayRecipe(at index: Int) {
        guard let url = recipe(at: index)?.imageURL else { return }
        service.cancelImageLoad(with: url)
    }

    func didSelectRecipe(at index: Int) {
        navigationDelegate?.didTapRecipe(recipes[index])
    }

    func loadRecipes() {
        service.cancelCurrenSearch()
        service.cancelLoadAllImages()

        recipes = []
        view?.reloadCollectionView()

        service.loadSearch(searchText) { [weak self] result in
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

extension SearchPresenter {
    private func reloadCollection() {
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
            guard self?.recipe(at: index) != nil else { return }
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
            return
        } else {
            navigationDelegate?.error(with: error.localizedDescription)
        }
    }
}
