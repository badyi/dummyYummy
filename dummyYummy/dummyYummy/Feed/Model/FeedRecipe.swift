//
//  FeedRecipeModel.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

struct FeedRecipe {
    let id: Int
    let title: String
    
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let gaps: String
    
    let weightWatcherSmartPoints: Int
    let aggregateLikes: Int
    let spoonacularScore: Int
    let healthScore: Int
    
    let pricePerServing: Double
    let readyInMinutes: Int
    let servings: Int
    
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    
    let sourceUrl: String
    let image: String?
    let spoonacularSourceURL: String?
    
    var imageData: Data?

    init(with responseRecipe: FeedServiceRecipe) {
        id = responseRecipe.id
        title = responseRecipe.title
        vegetarian = responseRecipe.vegetarian
        vegan = responseRecipe.vegan
        glutenFree = responseRecipe.glutenFree
        dairyFree = responseRecipe.dairyFree
        veryHealthy = responseRecipe.veryHealthy
        cheap = responseRecipe.cheap
        veryPopular = responseRecipe.veryPopular
        sustainable = responseRecipe.sustainable
        lowFodmap = responseRecipe.lowFodmap
        gaps = responseRecipe.gaps

        weightWatcherSmartPoints = responseRecipe.weightWatcherSmartPoints
        aggregateLikes = responseRecipe.aggregateLikes
        spoonacularScore = responseRecipe.spoonacularScore
        healthScore = responseRecipe.healthScore

        pricePerServing = responseRecipe.pricePerServing
        readyInMinutes = responseRecipe.readyInMinutes
        servings = responseRecipe.servings

        preparationMinutes = responseRecipe.preparationMinutes
        cookingMinutes = responseRecipe.cookingMinutes
        
        summary = responseRecipe.summary
        cuisines = responseRecipe.cuisines
        dishTypes = responseRecipe.dishTypes
        diets = responseRecipe.diets
        occasions = responseRecipe.occasions
        instructions = responseRecipe.instructions
        analyzedInstructions = responseRecipe.analyzedInstructions
        
        sourceUrl = responseRecipe.sourceUrl
        image = responseRecipe.image
        spoonacularSourceURL = responseRecipe.spoonacularSourceURL
        imageData = nil
    }
}
