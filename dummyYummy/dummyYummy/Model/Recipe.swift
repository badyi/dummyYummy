//
//  Recipe.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

final class Recipe {
    let id: Int
    let title: String

    var imageURL: String?
    var imageData: Data?

    var boolCharacteristics: [String: Bool]?

    var healthScore: Int?

    var pricePerServing: Double?
    var readyInMinutes: Int?
    var servings: Int?

    var cuisines: [String]?
    var dishTypes: [String]?
    var diets: [String]?

    var ingredients: [String]?
    var instructions: [String]?

    var sourceURL: String?

    var spoonacularSourceURL: String?

    var isFavorite: Bool = false

    init(with responseRecipe: RecipeInfoResponse) {
        id = responseRecipe.id
        title = responseRecipe.title

        boolCharacteristics = [:]
        boolCharacteristics?["Vegeterian"] = responseRecipe.vegetarian
        boolCharacteristics?["Gluten free"] = responseRecipe.glutenFree
        boolCharacteristics?["Vegan"] = responseRecipe.vegan
        boolCharacteristics?["Dairy free"] = responseRecipe.dairyFree
        boolCharacteristics?["Very healthy"] = responseRecipe.veryHealthy
        boolCharacteristics?["Cheap"] = responseRecipe.cheap
        boolCharacteristics?["Very popular"] = responseRecipe.veryPopular
        boolCharacteristics?["Sustainable"] = responseRecipe.sustainable
        boolCharacteristics?["Low fodmap"] = responseRecipe.lowFodmap

        ingredients = []
        responseRecipe.extendedIngredients.forEach {
            ingredients?.append($0.original)
        }

        instructions = []
        if !responseRecipe.analyzedInstructions.isEmpty {
            responseRecipe.analyzedInstructions[0].steps.forEach {
                instructions?.append($0.step)
            }
        }

        healthScore = responseRecipe.healthScore

        pricePerServing = responseRecipe.pricePerServing
        readyInMinutes = responseRecipe.readyInMinutes
        servings = responseRecipe.servings

        cuisines = responseRecipe.cuisines
        dishTypes = responseRecipe.dishTypes
        diets = responseRecipe.diets

        sourceURL = responseRecipe.sourceUrl
        imageURL = responseRecipe.image
        spoonacularSourceURL = responseRecipe.spoonacularSourceURL
    }

    init(with searchResult: SearchResult) {
        id = searchResult.id
        title = searchResult.title
        imageURL = searchResult.image
    }

    init(with recipeDTO: RecipeDTO) {
        id = recipeDTO.id
        boolCharacteristics = recipeDTO.boolCharacteristics
        cuisines = recipeDTO.cuisines
        diets = recipeDTO.diets
        dishTypes = recipeDTO.dishTypes
        healthScore = recipeDTO.healthScore
        title = recipeDTO.title
        imageURL = recipeDTO.imageURL
        pricePerServing = recipeDTO.pricePerServing
        readyInMinutes = recipeDTO.readyInMinutes
        servings = recipeDTO.servings
        ingredients = recipeDTO.ingredients
        instructions = recipeDTO.instructions
        sourceURL = recipeDTO.sourceURL
        spoonacularSourceURL = recipeDTO.spoonacularSourceURL
    }
}

extension Recipe {
    func configInfo(with responseRecipe: RecipeInfoResponse) {
        sourceURL = responseRecipe.sourceUrl
        spoonacularSourceURL = responseRecipe.spoonacularSourceURL

        boolCharacteristics = [:]
        boolCharacteristics?["Vegeterian"] = responseRecipe.vegetarian
        boolCharacteristics?["Gluten free"] = responseRecipe.glutenFree
        boolCharacteristics?["Vegan"] = responseRecipe.vegan
        boolCharacteristics?["Dairy free"] = responseRecipe.dairyFree
        boolCharacteristics?["Very healthy"] = responseRecipe.veryHealthy
        boolCharacteristics?["Cheap"] = responseRecipe.cheap
        boolCharacteristics?["Very popular"] = responseRecipe.veryPopular
        boolCharacteristics?["Sustainable"] = responseRecipe.sustainable
        boolCharacteristics?["Low fodmap"] = responseRecipe.lowFodmap

        ingredients = []
        responseRecipe.extendedIngredients.forEach {
            ingredients?.append($0.original)
        }

        instructions = []
        if !responseRecipe.analyzedInstructions.isEmpty {
            responseRecipe.analyzedInstructions[0].steps.forEach {
                instructions?.append($0.step)
            }
        }
    }
}

extension RecipeDTO {
    init(with recipe: Recipe) {
        id = recipe.id
        boolCharacteristics = recipe.boolCharacteristics
        cuisines = recipe.cuisines
        diets = recipe.diets
        dishTypes = recipe.dishTypes
        healthScore = recipe.healthScore
        title = recipe.title
        imageURL = recipe.imageURL
        pricePerServing = recipe.pricePerServing
        readyInMinutes = recipe.readyInMinutes
        servings = recipe.servings
        ingredients = recipe.ingredients
        instructions = recipe.instructions
        sourceURL = recipe.sourceURL
        spoonacularSourceURL = recipe.spoonacularSourceURL
    }
}
