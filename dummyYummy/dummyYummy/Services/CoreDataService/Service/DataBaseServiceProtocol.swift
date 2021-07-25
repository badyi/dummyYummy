//
//  DataBaseServiceProtocol.swift
//  dummyYummy
//
//  Created by badyi on 25.07.2021.
//

import Foundation

protocol DataBaseServiceProtocol {
    init(coreDataStack: CoreDataStackProtocol)

    /// Update recipe in store, if it doesn't exist it will be stored
    /// - Parameter recipes: recipeDTOs
    func update(recipes: [RecipeDTO])

    /// Delete from store
    /// - Parameter recipes: recipeDTOs
    func delete(recipes: [RecipeDTO]?)

    /// Delete all recipes from store
    func deleteAll()

    /// Get recipes with specific predicate
    /// - Parameter predicate: specifies how data should be fetched or filtered.
    func recipes(with predicate: NSPredicate) -> [RecipeDTO]

    /// Get all stored recipes
    func allRecipes() -> [RecipeDTO]
}
