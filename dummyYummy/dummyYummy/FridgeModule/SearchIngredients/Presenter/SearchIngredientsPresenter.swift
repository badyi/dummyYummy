//
//  SearchIngredientsPresenter.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class SearchIngredientsPresenter: NSObject {
    weak var view: SearchIngredientsViewProtocol?
    private var networkService: SearchIngredientsNetworkProtocol?
    private var ingredients: [String]
    private var chosenIngredinets: [String]

    init(with view: SearchIngredientsViewProtocol,
         _ networkService: SearchIngredientsNetworkProtocol) {
        self.view = view
        self.networkService = networkService
        ingredients = []
        chosenIngredinets = []
    }
}

// MARK: - SearchIngredientsPresenterProtocol
extension SearchIngredientsPresenter: SearchIngredientsPresenterProtocol {

    func viewDidLoad() {
        view?.setupView()
    }

    func viewWillAppear() {

    }

    func viewWillDisappear() {

    }

    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
        }
    }

    func willDisplayCell(at indexPath: IndexPath) {

    }

    func didEndDisplayingCell(at indexPath: IndexPath) {

    }

    func didSelectCell(at indexPath: IndexPath) {

    }

    func title(at indexPath: IndexPath) -> String {
        ingredients[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource
extension SearchIngredientsPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredinentsCell.id,
                                                       for: indexPath) as? IngredinentsCell else {
            return tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        }

        let ingredient = ingredients[indexPath.row]
        cell.config(with: ingredient, chosenIngredinets.contains(ingredient))

        cell.handleChoseButtonTap = {
            if self.chosenIngredinets.contains(ingredient),
               let index = self.chosenIngredinets.firstIndex(of: ingredient) {
                self.chosenIngredinets.remove(at: index)
            } else {
                self.chosenIngredinets.append(ingredient)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
}

extension SearchIngredientsPresenter {
    func loadSearch(_ query: String) {
        networkService?.loadIngredients(100, query, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.ingredients = result.map({ $0.name })
                self?.reloadTable()
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}

// MARK: - UISearchResultsUpdating
extension SearchIngredientsPresenter: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        loadSearch(text)
    }
}
