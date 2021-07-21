//
//  SearchNetworkResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 29.06.2021.
//

import Foundation

final class SearchNetworkResourceFactory: ResourceFactoryProtocol {

    // MARK: - Resource creation
    func createSearchRecipesResource(_ query: String) -> Resource<SearchResponse>? {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch"

        let headers = ["x-rapidapi-key": Constants.xRapidapiKey,
                       "x-rapidapi-host": Constants.xRapidapiHost]
        let parameters = ["query": query]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<SearchResponse>(url: url, headers: headers)
    }
}
