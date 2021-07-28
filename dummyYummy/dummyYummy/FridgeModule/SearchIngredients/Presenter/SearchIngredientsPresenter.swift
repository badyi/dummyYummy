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

    var navigationDelegate: SearchIngredientsNavigationDelegate?

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
            delete(at: index)
        } else {
            append(ingredient)
        }
    }

    func ingredientsCount() -> Int {
        return ingredients.count
    }

    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
        }
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
                self?.handleError(error)
            }
        })
    }
}

extension SearchIngredientsPresenter {

    private func delete(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.chosenIngredinets.remove(at: index)
            self?.view?.removed(at: IndexPath(row: index, section: 0))
        }
    }

    private func append(_ ingredient: String) {
        DispatchQueue.main.async { [weak self] in
            self?.chosenIngredinets.append(ingredient)
            self?.view?.reloadTable()
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
