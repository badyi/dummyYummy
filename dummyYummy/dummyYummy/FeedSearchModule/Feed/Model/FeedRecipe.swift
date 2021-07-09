//
//  FeedRecipeModel.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

struct FeedRecipe {
    let id: Int
    let title: String
    
    var imageURL: String? = nil
    var imageData: Data? = nil
    var image: UIImage? = nil
    
    var boolCharacteristics: [String: Bool]?
//    var intCharacteristics: [String: Int] = [:]
//    var vegetarian: Bool? = nil
//    var vegan: Bool? = nil
//    var glutenFree: Bool? = nil
//    var dairyFree: Bool? = nil
//    var veryHealthy: Bool? = nil
//    var cheap: Bool? = nil
//    var veryPopular: Bool? = nil
//    var sustainable: Bool? = nil
//    var lowFodmap: Bool? = nil
 //   var gaps: String? = nil
    
    var healthScore: Int? = nil
    
    var pricePerServing: Double? = nil
    var readyInMinutes: Int? = nil
    var servings: Int? = nil
    
//    var preparationMinutes: Int? = nil
//    var cookingMinutes: Int? = nil
    
    var cuisines: [String]? = nil
    var dishTypes: [String]? = nil
    var diets: [String]? = nil
//    var occasions: [String]? = nil
    var instructions: String? = nil
    var analyzedInstructions: [AnalyzedInstruction]? = nil
    
    var sourceUrl: String? = nil
    
    var spoonacularSourceURL: String? = nil

    init(with responseRecipe: FeedServiceRecipe) {
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
        //boolCharacteristics["gaps"] = responseRecipe.sustainable
        //vegetarian = responseRecipe.vegetarian
        //vegan = responseRecipe.vegan
        //glutenFree = responseRecipe.glutenFree
        //dairyFree = responseRecipe.dairyFree
        //veryHealthy = responseRecipe.veryHealthy
        //cheap = responseRecipe.cheap
        //veryPopular = responseRecipe.veryPopular
        //sustainable = responseRecipe.sustainable
        //lowFodmap = responseRecipe.lowFodmap
        //gaps = responseRecipe.gaps
        
        healthScore = responseRecipe.healthScore

        pricePerServing = responseRecipe.pricePerServing
        readyInMinutes = responseRecipe.readyInMinutes
        servings = responseRecipe.servings

//        preparationMinutes = responseRecipe.preparationMinutes
//        cookingMinutes = responseRecipe.cookingMinutes
//
        cuisines = responseRecipe.cuisines
        dishTypes = responseRecipe.dishTypes
        diets = responseRecipe.diets
        //occasions = responseRecipe.occasions
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

extension FeedRecipe {
}
