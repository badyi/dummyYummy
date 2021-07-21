//
//  DetailResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

final class DetailResourceFactory: DetailResourceFactoryProtocol {
    func createRecipesInfoResource(_ id: Int) -> Resource<RecipeInfoResponse>? {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information"

        let headers = ["x-rapidapi-key": Constants.xRapidapiKey,
                       "x-rapidapi-host": Constants.xRapidapiHost]
        let parameters: [String: Any] = [:]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<RecipeInfoResponse>(url: url, headers: headers)
    }
}
