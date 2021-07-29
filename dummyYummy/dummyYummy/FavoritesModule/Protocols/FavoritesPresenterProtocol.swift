//
//  FavoritesPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

protocol FavoritesPresenterProtocol {
    init(with view: FavoritesViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol)

    /// Get recipe title at index
    /// - Parameter index: index of recipe
    func recipeTitle(at index: Int) -> String?

    /// Recipe was selected at index
    /// - Parameter index: index of recipe
    func didSelectRecipe(at index: Int)

    /// Get recipes from db
    func retriveRecipes()

    /// Count of recipes
    func recipesCount() -> Int

    /// Get recipe at index
    /// - Parameter index: index of recipe
    func recipe(at index: Int) -> Recipe?

    /// Handle tap on favorite button for recipe at index
    /// - Parameter index: index of recipe
    func handleFavoriteTap(at index: Int)

    /// Handle tap on share button for recipe at index
    /// - Parameter index: index of recipe
    func handleShareButtonTap(at index: Int)

    /// Update searching text
    /// - Parameter text: new search text
    func updateSearchText(_ text: String)
}
