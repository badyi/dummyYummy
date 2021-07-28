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

    func prepareRecipe(at index: Int)
    func noNeedPrepearRecipe(at index: Int)
    func didSelectRecipe(at index: Int)

    func loadRandomRecipes()
    func loadRandomRecipesIfNeeded()

    func handleFavoriteTap(at index: Int)
    func handleShareTap(at index: Int)
    func isFavorite(at index: Int) -> Bool

    func recipeTitle(at index: Int) -> String?
    func recipesCount() -> Int
    func recipe(at index: Int) -> Recipe?
}
