//
//  DataBaseService.swift
//  dummyYummy
//
//  Created by badyi on 14.07.2021.
//

import Foundation
import CoreData

protocol DataBaseServiceProtocol {
    init(coreDataStack: CoreDataStackProtocol)
    
    /// Update recipe in store, if it doesn't exist it will be stored
    /// - Parameter recipes: recipeDTOs
    func update(recipes: [RecipeDTO])
    
    /// Delete from store
    /// - Parameter recipes: recipeDTOs
    func delete(recipes: [RecipeDTO]?)
    func deleteAll()
    func recipes(with predicate: NSPredicate) -> [RecipeDTO]
    func allRecipes() -> [RecipeDTO]
}

final class DataBaseService {
    
    private let stack: CoreDataStackProtocol
    
    init(coreDataStack: CoreDataStackProtocol) {
        stack = coreDataStack
    }
}

extension DataBaseService: DataBaseServiceProtocol {
    func update(recipes: [RecipeDTO]) {
        let context = stack.backgroundContext
        context.performAndWait {
            recipes.forEach {
                if let moRecipe = try? self.fetchRequest(for: $0).execute().first {
                    moRecipe.update(with: $0)
                } else {
                    let moRecipe = MORecipe(context: context)
                    moRecipe.configNew(with: $0)
                }
            }
            stack.saveContext()
        }
    }
    
    func delete(recipes: [RecipeDTO]?) {
        let context = stack.backgroundContext
        
        context.performAndWait {
            recipes?.forEach {
                if let recipe = try? self.fetchRequest(for: $0).execute().first {
                    context.delete(recipe)
                }
            }
            stack.saveContext()
        }
    }
    
    func deleteAll() {
        let context = stack.backgroundContext
        let fetchRequest = NSFetchRequest<MORecipe>(entityName: stack.entityName)
        context.performAndWait {
            let recipes = try? fetchRequest.execute()
            recipes?.forEach {
                context.delete($0)
            }
            stack.saveContext()
        }
    }
    
    func recipes(with predicate: NSPredicate) -> [RecipeDTO] {
        let context = stack.mainContext
        var result = [RecipeDTO]()
        
        let request = NSFetchRequest<MORecipe>(entityName: stack.entityName)
        request.predicate = predicate
        context.performAndWait {
            guard let recipes = try? request.execute() else { return }
            result = recipes.map { RecipeDTO(with: $0) }
        }
        
        return result
    }
    
    func allRecipes() -> [RecipeDTO] {
        let context = stack.mainContext
        var result = [RecipeDTO]()
        
        let request = NSFetchRequest<MORecipe>(entityName: stack.entityName)
        context.performAndWait {
            guard let recipes = try? request.execute() else { return }
            result = recipes.map { RecipeDTO(with: $0) }
        }
        
        return result
    }
}

private extension DataBaseService {
    func fetchRequest(for dto: RecipeDTO) -> NSFetchRequest<MORecipe> {
        let request = NSFetchRequest<MORecipe>(entityName: stack.entityName)
        request.predicate = .init(format: "id == %@", NSNumber(value: dto.id))
        return request
    }
}

fileprivate extension RecipeDTO {
    init(with MORecipe: MORecipe) {
        id = Int(MORecipe.id)
        boolCharacteristics = MORecipe.boolCharacteristics
        cuisines = MORecipe.cuisines
        diets = MORecipe.diets
        dishTypes = MORecipe.dishTypes
        healthScore = Int(MORecipe.healthScore)
        title = MORecipe.title ?? ""
        imageURL = MORecipe.imageURL
        pricePerServing = MORecipe.pricePerServing
        readyInMinutes = Int(MORecipe.readyInMinutes)
        servings = Int(MORecipe.servings)
        ingredients = MORecipe.ingredients
        instructions = MORecipe.instructions
        sourceURL = MORecipe.sourceURL
        spoonacularSourceURL = MORecipe.spoonacularSourceURL
    }
}

fileprivate extension MORecipe {
    func update(with recipeDTO: RecipeDTO) {
        boolCharacteristics = recipeDTO.boolCharacteristics
        cuisines = recipeDTO.cuisines
        diets = recipeDTO.diets
        dishTypes = recipeDTO.dishTypes
        healthScore = Int64(recipeDTO.healthScore ?? -1)
        title = recipeDTO.title
        imageURL = recipeDTO.imageURL
        pricePerServing = recipeDTO.pricePerServing ?? -1
        readyInMinutes = Int64(recipeDTO.readyInMinutes ?? -1)
        servings = Int64(recipeDTO.servings ?? -1)
        ingredients = recipeDTO.ingredients
        instructions = recipeDTO.instructions
        sourceURL = recipeDTO.sourceURL
        spoonacularSourceURL = recipeDTO.spoonacularSourceURL
    }
    
    func configNew(with recipeDTO: RecipeDTO) {
        id = Int64(recipeDTO.id)
        update(with: recipeDTO)
    }
}
