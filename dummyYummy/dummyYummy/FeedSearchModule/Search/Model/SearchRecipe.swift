//
//  SearchRecipeModel.swift
//  dummyYummy
//
//  Created by badyi on 30.06.2021.
//

import Foundation

final class SearchRecipe {
    let id: Int
    let title: String
    let imageURL: String?
    let nutrients: [Nutrient]?
    var imageData: Data?
    
    init(with searchResult: SearchResult) {
        id = searchResult.id
        title = searchResult.title
        imageURL = searchResult.image
        nutrients = searchResult.nutrition?.nutrients.map {
            Nutrient(with: $0)
        }
        imageData = nil
    }
}

final class Nutrient {
    let title: String
    let name: String
    let amount: Double
    let unit: String
    
    init(with searchNutrient: SearchNutrient) {
        title = searchNutrient.title
        name = searchNutrient.name
        amount = searchNutrient.amount
        unit = searchNutrient.unit.rawValue
    }
}
