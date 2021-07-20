//
//  SearchPresenter.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

final class SearchPresenter: NSObject {
    weak var view: SearchViewProtocol?
    private var service: SearchNetworkServiceProtocol
    public private(set) var refinements: SearchRefinements

    weak var navigationDelegate: SearchNavigationDelegate?

    var recipes: [Recipe]

    init(with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol) {
        self.service = networkService
        recipes = []
        self.view = view
        refinements = SearchRefinements()
    }
}

extension SearchPresenter: SearchPresenterProtocol {

    func searchRefinementsTapped() {
        navigationDelegate?.didTapSearchSettingsButton(refinements)
    }

    func resultCount() -> Int {
        recipes.count
    }

    func viewDidLoad() {
        view?.setupView()
    }

    func viewWillAppear() {
        view?.configNavigation()
    }

    func willDisplayCell(at index: IndexPath) {
        loadImageIfNeeded(for: recipes[index.row], at: index)
    }

    func didEndDisplayCell(at index: IndexPath) {
        #warning("code here")
    }

    func didSelectCell(at index: IndexPath) {
        navigationDelegate?.didTapCell(with: recipes[index.row])
    }

    func updateRefinements(_ refinements: SearchRefinements) {
        self.refinements = refinements
    }

    func updateSearchResult(_ query: String) {
        loadRecipes(with: query)
    }
}

private extension SearchPresenter {
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollection()
        }
    }
}

extension SearchPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.id,
                                                            for: indexPath) as? SearchResultCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }

        cell.config(with: recipes[indexPath.row])

        return cell
    }
}

private extension SearchPresenter {
    func loadRecipes(with query: String) {
        service.loadSearch(query) { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.results.map {
                    Recipe(with: $0)
                }
                self?.reloadCollection()
            case let .failure(error):
                #warning("Fix to alert")
                print(error.localizedDescription)
            }
        }
    }

    func loadImageIfNeeded(for recipe: Recipe, at index: IndexPath) {
        guard let imageURL = recipe.imageURL, recipe.imageData == nil else {
            return
        }
        service.loadImage(at: index, with: imageURL, completion: {
            [weak self] result in
                switch result {
                case let .success(result):
                    self?.setImageData(at: index, result)
                    self?.imageDidLoad(at: index)
                case let .failure(error):
                    #warning("Fix to alert")
                    print(error.localizedDescription)
                }
        })
    }

    func setImageData(at index: IndexPath, _ data: Data) {
        recipes[index.row].imageData = data
    }

    func imageDidLoad(at index: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [index])
        }
    }
}
