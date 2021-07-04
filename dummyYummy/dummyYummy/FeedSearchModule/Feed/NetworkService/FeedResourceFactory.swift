//
//  FeedResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

final class FeedResourceFactory {
    
    // MARK: - Resource creation
    func createRandomRecipesResource(_ count: Int) -> Resource<FeedRecipeResponse>? {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=1&tags=vegetarian%2Cdessert"
        
        let headers = ["x-rapidapi-key": Constants.xRapidapiKey,
                       "x-rapidapi-host": Constants.xRapidapiHost]
        let parameters = ["number" : "\(count)"]
        
        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<FeedRecipeResponse>(url: url, headers: headers)
    }
    
    func createImageResource(_ url: String) -> Resource<Data>? {
        guard let url = URL(string: url) else { return nil }
    
        let parse: (Data) throws -> Data = { data in
            return data
        }
        return Resource<Data>(url: url, method: .get, parse: parse)
    }
}

extension FeedResourceFactory {
    
    // MARK: - Building url
    private func buildURL(_ baseURL: String,_ parameters: [String: Any]) -> URL? {
        guard let url = URL(string: baseURL) else { return nil }
        
        var com = URLComponents(url: url, resolvingAgainstBaseURL: false)
        com?.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            com?.queryItems?.append(item)
        }
        
        return com?.url
    }
}
