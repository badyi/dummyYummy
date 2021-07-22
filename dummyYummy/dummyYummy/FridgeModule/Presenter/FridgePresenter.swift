//
//  FridgePresenter.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

final class FridgePresenter {
    weak var view: FridgeViewProtocol?
    private var networkService: FridgeNetworkServiceProtocol
    private(set) var chosenIngredients: [String]

    init(with view: FridgeViewProtocol, _ networkService: FridgeNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        chosenIngredients = []
    }
}

extension FridgePresenter: FridgePresenterProtocol {
    func setChosenIngredients(_ ingredients: [String]) {
        chosenIngredients = ingredients
    }
}

private extension FridgePresenter {

}
