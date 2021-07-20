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

    var imageURL: String?

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
}
