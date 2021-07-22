//
//  SearchIngredientsPresenter.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

final class SearchIngredientsPresenter: NSObject {
    weak var view: SearchIngredientsViewProtocol?
    private var networkService: SearchIngredientsNetworkProtocol?
    private var ingredients: [String]
    private(set) var chosenIngredinets: [String]

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
    func setChosenIngredients(_ ingredients: [String]) {
        chosenIngredinets = ingredients
    }

    func isChosen(_ ingredient: String) -> Bool {
        chosenIngredinets.contains(ingredient)
    }

    func handleChooseTap(at ingredient: String) {
        if self.chosenIngredinets.contains(ingredient),
           let index = self.chosenIngredinets.firstIndex(of: ingredient) {
            self.chosenIngredinets.remove(at: index)
        } else {
            self.chosenIngredinets.append(ingredient)
        }
        #warning("reload rows")
        view?.reloadTable()
    }

    func ingredientsCount() -> Int {
        return ingredients.count
    }

    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
        }
    }

    func didSelectRecipe(at index: Int) {

    }

    func title(at index: Int) -> String {
        ingredients[index]
    }

    func loadSearch(_ query: String) {
        networkService?.cancelSearchTask()
        ingredients = []
        view?.reloadTable()
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
