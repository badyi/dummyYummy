//
//  FakeDBService.swift
//  dummyYummyTests
//
//  Created by badyi on 28.07.2021.
//

import Foundation

final class FakeDBService: DataBaseServiceProtocol {

    var recipesStore: [Int: RecipeDTO]

    init(coreDataStack: CoreDataStackProtocol) {
        recipesStore = [:]
    }

    func update(recipes: [RecipeDTO]) {
        recipes.forEach {
            recipesStore[$0.id] = $0
        }
    }

    func delete(recipes: [RecipeDTO]?) {
        recipes?.forEach {
            recipesStore[$0.id] = nil
        }
    }

    func deleteAll() {
        recipesStore = [:]
    }

    func recipes(with predicate: NSPredicate) -> [RecipeDTO] {
        var predicateFormat = predicate.predicateFormat
        let range = predicateFormat.range(of: "id == ")!
        predicateFormat.removeSubrange(range)
        if let recipe = recipesStore[Int(predicateFormat)!] {
            return [recipe]
        }
        return []
    }

    func allRecipes() -> [RecipeDTO] {
        return recipesStore.map { $0.value }
    }
}
