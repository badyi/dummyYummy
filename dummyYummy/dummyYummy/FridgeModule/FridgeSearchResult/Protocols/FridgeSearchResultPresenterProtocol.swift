//
//  FridgeSearchResultPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
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
