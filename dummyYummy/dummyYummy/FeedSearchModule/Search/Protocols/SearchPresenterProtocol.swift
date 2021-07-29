//
//  SearchPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {

    init (with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol)

    /// Prepare a recipe for viewing
    /// - Parameter index: index of recipe
    func prepareRecipe(at index: Int)

    /// No more need prepear recipe
    /// - Parameter index: index of recipe
    func noNeedPrepearRecipe(at index: Int)

    /// Recipe was selected at index
    /// - Parameter index: index of recipe
    func didSelectRecipe(at index: Int)

    /// Load recipes with search text
    func loadRecipes()

    /// Update search text
    /// - Parameter query: search query
    func updateSearchText(_ query: String)

    /// Count of recipes
    func recipesCount() -> Int

    /// Get recipe at index
    /// - Parameter index: index of recipe
    func recipe(at index: Int) -> Recipe?
}
