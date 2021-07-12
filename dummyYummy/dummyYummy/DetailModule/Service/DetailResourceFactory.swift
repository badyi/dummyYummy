//
//  DetailResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

final class DetailResourceFactory {
    func createRecipesInfoResource(_ id: Int) -> Resource<FeedRecipeInfoResponse>? {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information"
        
        let headers = ["x-rapidapi-key": Constants.xRapidapiKey,
                       "x-rapidapi-host": Constants.xRapidapiHost]
        let parameters: [String: Any] = [:]

        guard let url = buildURL(urlString, parameters) else {
            return nil
        }
        return Resource<FeedRecipeInfoResponse>(url: url, headers: headers)
    }
    
    func createImageResource(_ url: String) -> Resource<Data>? {
        guard let url = URL(string: url) else { return nil }
    
        let parse: (Data) throws -> Data = { data in
            return data
        }
        return Resource<Data>(url: url, method: .get, parse: parse)
    }
}

extension DetailResourceFactory {
    
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
