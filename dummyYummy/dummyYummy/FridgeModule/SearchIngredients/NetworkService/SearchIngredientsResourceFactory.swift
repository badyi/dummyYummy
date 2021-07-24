//
//  SearchIngredientsResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import Foundation

final class SearchIngredientsResourceFactory: SearchIngredientsResourceFactoryProtocol {

    // MARK: - Resource creation
    func createIngredientsResource(_ count: Int, _ query: String) -> Resource<IngredientsResponse>? {

        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/autocomplete?"

        let headers = ["x-rapidapi-key": NetworkConstants.xRapidapiKey,
                       "x-rapidapi-host": NetworkConstants.xRapidapiHost]
        let parameters = ["query": query, "number": "\(count)"]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<IngredientsResponse>(url: url, headers: headers)
    }
}
