//
//  DetailPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol DetailPresenterProtocol {

    init(with view: DetailViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol,
         _ networkService: DetailNetworkServiceProtocol,
         _ recipe: Recipe)

    /// Check is current recipe favorite
    func checkFavoriteStatus()

    /// Prepare info about recipe
    func prepareIngredientsAndInstructions()
    func prepareCharacteristics()

    /// Load image if recipe doesn't have one
    func loadImageIfNeeded()

    /// Get header title
    func headerTitle() -> String

    /// Get ingredient title at indexPath
    /// - Parameter indexPath: indexPath of ingredient
    func ingredientTitle(at indexPath: IndexPath) -> String

    /// Get instruction title at indexPath
    /// - Parameter indexPath: indexPath of instruction
    func instructionTitle(at indexPath: IndexPath) -> String

    /// Get characteristic at indexPath
    /// - Parameter indexPath: indexPath of characteristic
    func characteristic(at indexPath: IndexPath) -> String

    /// Get all characteristics
    func getCharacteristics() -> ExpandableCharacteristics

    /// Handle tap on header for some section
    /// - Parameter section: number of section
    func headerTapped(_ section: Int)

    /// Get recipe
    func getRecipe() -> Recipe

    /// Handle tap on favorite button
    /// - Parameter indexPath: indexPath need to reload section
    func handleFavoriteTap(at indexPath: IndexPath)

    /// Handle tap on favorite button
    /// - Parameter indexPath: indexPath need to reload section
    func handleShareTap(at indexPath: IndexPath)

    /// Handle segment control value change
    func segmentDidChange()
}
