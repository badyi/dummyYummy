//
//  FeedPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 18.07.2021.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {

    init(with view: FeedViewProtocol,
         _ networkService: FeedNetworkServiceProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol)

    /// Prepare a recipe for viewing
    /// - Parameter index: index of recipe
    func prepareRecipe(at index: Int)

    /// No need to prepare anymore
    /// - Parameter index: index of recipe
    func noNeedPrepearRecipe(at index: Int)

    /// Select recipe at index
    /// - Parameter index: index of recipe
    func didSelectRecipe(at index: Int)

    /// Load random recipes
    func loadRandomRecipes()

    /// If there is no recipes it will be loaded
    func loadRandomRecipesIfNeeded()

    /// Handle tap on favorite button for recipe at index
    /// - Parameter index: index of recipe
    func handleFavoriteTap(at index: Int)

    /// Handle tap on share button for recipe at index
    /// - Parameter index: index of recipe
    func handleShareTap(at index: Int)

    /// Check recipe favorite status
    /// - Parameter index: index of recipe
    func isFavorite(at index: Int) -> Bool

    /// title of recipe at index
    /// - Parameter index: index of recipe
    func recipeTitle(at index: Int) -> String?

    /// Count of all recipes
    func recipesCount() -> Int

    /// Get recipe at index
    /// - Parameter index: index of recipe
    func recipe(at index: Int) -> Recipe?
}
