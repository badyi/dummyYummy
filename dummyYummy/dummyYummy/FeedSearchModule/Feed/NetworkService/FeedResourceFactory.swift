//
//  FeedResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

final class FeedResourceFactory: FeedResourceFactoryProtocol {

    // MARK: - Resource creation
    func createRandomRecipesResource(_ count: Int) -> Resource<RecipesResponse>? {
        let host = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        let query = "/recipes/random?number=1&tags=vegetarian%2Cdessert"
        let urlString = host + query

        let headers = ["x-rapidapi-key": NetworkConstants.xRapidapiKey,
                       "x-rapidapi-host": NetworkConstants.xRapidapiHost]
        let parameters = ["number": "\(count)"]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<RecipesResponse>(url: url, headers: headers)
    }
}
