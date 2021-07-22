//
//  FeedPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 18.07.2021.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    init(with view: FeedViewProtocol,
         _ networkService: FeedServiceProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol)

    // MARK: - Input
    func willDisplayRecipe(at index: Int)
    func didEndDisplayingRecipe(at index: Int)
    func didSelectRecipe(at index: Int)

    func loadRandomRecipes()
    func loadRandomRecipesIfNeeded()
    func handleFavoriteTap(at index: Int)

    // MARK: - Output
    func recipeTitle(at index: Int) -> String?
    func recipesCount() -> Int
    func recipe(at index: Int) -> Recipe?
    func checkFavoriteStatus(at index: Int) -> Bool
}
