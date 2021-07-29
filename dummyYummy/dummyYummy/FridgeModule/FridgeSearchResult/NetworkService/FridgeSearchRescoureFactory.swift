//
//  FridgeSearchRescoureFactory.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import Foundation

final class FridgeSearchRescoureFactory: ResourceFactoryProtocol {
    // MARK: - Resource creation
    func createRandomRecipesResource(_ ingredients: [String], _ count: Int) -> Resource<[SearchResult]>? {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients"

        let headers = ["x-rapidapi-key": NetworkConstants.xRapidapiKey,
                       "x-rapidapi-host": NetworkConstants.xRapidapiHost]
        var ingredientsString = ingredients.reduce("", { result, value in
            var addingValue = ""
            if result != "" {
                addingValue += ","
            }
            addingValue += value
            return value
        })

        if ingredientsString.last == "," {
            ingredientsString.removeLast()
        }

        let parameters = ["ingredients": ingredientsString,
                          "number": "\(count)"]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<[SearchResult]>(url: url, headers: headers)
    }
}
