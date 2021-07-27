//
//  FridgePresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FridgePresenterProtocol {
    init (with view: FridgeViewProtocol, _ networkService: FridgeNetworkServiceProtocol)

    func ingredientsCount() -> Int
    func setChosenIngredients(_ ingredients: [String])
    func title(at index: Int) -> String
    func delete(at index: Int)
    func didTapSearchButton()
}

protocol FridgeNavigationDelegate: RecipesViewNavigationDelegate {
    func didTapSearch(_ ingredients: [String])
    func activity(with url: String)
    func error(with description: String)
}
