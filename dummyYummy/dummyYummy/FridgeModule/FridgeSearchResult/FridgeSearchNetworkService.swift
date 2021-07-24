//
//  FridgeNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol FridgeSearchNetworkServiceProtocol: NetworkServiceProtocol {
    func loadRecipes(_ ingredients: [String], _ count: Int,
                     completion: @escaping(OperationCompletion<[SearchResult]>) -> Void)
    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)
    func cancelLoadImage(with url: String)
}

final class FridgeSearchNetworkService {
    private(set) var networkHelper: NetworkHelper = NetworkHelper(reachability: Reachability())
    private var searchWithIngredients: [String]?
    private var searchRequest: Cancellation?
    private var imageLoad: [String: Cancellation] = [:]
}

extension FridgeSearchNetworkService: FridgeSearchNetworkServiceProtocol {

    func loadRecipes(_ ingredients: [String], _ count: Int,
                     completion: @escaping(OperationCompletion<[SearchResult]>) -> Void) {

        if searchRequest != nil, searchWithIngredients == ingredients {
            completion(.failure(ServiceError.alreadyLoading))
            return
        }

        guard let resource = FridgeSearchRescoureFactory().createRandomRecipesResource(ingredients, count) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }
        searchRequest = networkHelper.load(resource: resource, completion: { result in
            switch result {
            case let .success(result):
                completion(.success(result))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }

    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void) {
        guard let resource = SearchNetworkResourceFactory().createImageResource(url) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        if imageLoad[url] != nil {
            return
        }

        imageLoad[url] = load(resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func cancelLoadImage(with url: String) {
        if let task = imageLoad[url] {
            task.cancel()
        }
    }
}

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
