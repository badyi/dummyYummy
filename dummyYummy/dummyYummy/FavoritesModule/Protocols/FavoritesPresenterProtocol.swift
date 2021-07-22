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

    func recipeTitle(at index: Int) -> String?
    func didSelectRecipe(at index: Int)
    func retriveRecipes()
    func recipesCount() -> Int
    func recipe(at index: Int) -> Recipe?
    func handleFavoriteTap(at index: Int)
    func updateSearchText(_ text: String)
}
