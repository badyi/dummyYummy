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
    
    var imageURL: String? = nil
    var imageData: Data? = nil
    
    var vegetarian: Bool? = nil
    var vegan: Bool? = nil
    var glutenFree: Bool? = nil
    var dairyFree: Bool? = nil
    var veryHealthy: Bool? = nil
    var cheap: Bool? = nil
    var veryPopular: Bool? = nil
    var sustainable: Bool? = nil
    var lowFodmap: Bool? = nil
    var gaps: String? = nil
    
    var weightWatcherSmartPoints: Int? = nil
    var aggregateLikes: Int? = nil
    var spoonacularScore: Int? = nil
    var healthScore: Int? = nil
    
    var pricePerServing: Double? = nil
    var readyInMinutes: Int? = nil
    var servings: Int? = nil
    
    var preparationMinutes: Int? = nil
    var cookingMinutes: Int? = nil
    
    var summary: String? = nil
    var cuisines: [String]? = nil
    var dishTypes: [String]? = nil
    var diets: [String]? = nil
    var occasions: [String]? = nil
    var instructions: String? = nil
    var analyzedInstructions: [AnalyzedInstruction]? = nil
    
    var sourceUrl: String? = nil
    
    var spoonacularSourceURL: String? = nil

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
        imageURL = responseRecipe.image
        spoonacularSourceURL = responseRecipe.spoonacularSourceURL
        imageData = nil
    }
    
    init(with searchResult: SearchResult) {
        id = searchResult.id
        title = searchResult.title
        imageURL = searchResult.image
        imageData = nil
    }
}
