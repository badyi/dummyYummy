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

