//
//  RecipeDTO.swift
//  dummyYummy
//
//  Created by badyi on 14.07.2021.
//

import Foundation

struct RecipeDTO {
    let id: Int
    let title: String
    
    var imageURL: String? = nil
    
    var boolCharacteristics: [String: Bool]?
    
    var healthScore: Int? = nil
    
    var pricePerServing: Double? = nil
    var readyInMinutes: Int? = nil
    var servings: Int? = nil
    
    var cuisines: [String]? = nil
    var dishTypes: [String]? = nil
    var diets: [String]? = nil
    
    var ingredients: [String]? = nil
    var instructions: [String]? = nil
    
    var sourceURL: String? = nil
    
    var spoonacularSourceURL: String? = nil
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
