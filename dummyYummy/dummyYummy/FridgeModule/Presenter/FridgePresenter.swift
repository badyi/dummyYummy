//
//  FridgePresenter.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

final class FridgePresenter {
    weak var view: FridgeViewProtocol?
    private(set) var chosenIngredients: [String]

    var navigationDelegate: FridgeNavigationDelegate?

    init(with view: FridgeViewProtocol) {
        self.view = view
        chosenIngredients = []
    }
}

extension FridgePresenter: FridgePresenterProtocol {
    func didTapSearchButton() {
        navigationDelegate?.didTapSearch(chosenIngredients)
    }

    func title(at index: Int) -> String {
        return chosenIngredients[index]
    }

    func ingredientsCount() -> Int {
        return chosenIngredients.count
    }

    func delete(at index: Int) {
        chosenIngredients.remove(at: index)
    }

    func setChosenIngredients(_ ingredients: [String]) {
        chosenIngredients = ingredients
        reloadTable()
    }
}

extension FridgePresenter {
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
        }
    }
}
