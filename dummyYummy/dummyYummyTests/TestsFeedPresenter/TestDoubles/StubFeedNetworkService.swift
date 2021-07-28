//
//  StubFeedNetworkService.swift
//  dummyYummyTests
//
//  Created by badyi on 28.07.2021.
//

import UIKit

final class StubFeedNetworkService: FeedNetworkServiceProtocol {
    var networkHelper: NetworkHelper = NetworkHelper(reachability: FakeReachability(isReachable: true))

    func clearAndCancelAll() {}

    func loadRandomRecipes(_ count: Int, completion: @escaping (OperationCompletion<RecipesResponse>) -> Void) {

        let recipe = RecipeInfoResponse(vegetarian: true,
                                        vegan: true,
                                        glutenFree: false,
                                        dairyFree: false,
                                        veryHealthy: true,
                                        cheap: false,
                                        veryPopular: true,
                                        sustainable: false,
                                        weightWatcherSmartPoints: 1,
                                        gaps: "no",
                                        lowFodmap: true,
                                        aggregateLikes: 1,
                                        spoonacularScore: 1,
                                        healthScore: 1,
                                        pricePerServing: 10,
                                        extendedIngredients: [], id: 1,
                                        title: "testTitle",
                                        readyInMinutes: 45,
                                        servings: 2,
                                        sourceUrl: "testSourceUrl",
                                        image: "testImageURL",
                                        summary: "testSummary",
                                        cuisines: [],
                                        dishTypes: [],
                                        diets: [],
                                        occasions: [],
                                        instructions: nil,
                                        analyzedInstructions: [],
                                        spoonacularSourceURL: "testSpoonacularSourceURL",
                                        preparationMinutes: nil,
                                        cookingMinutes: nil)
        let response = RecipesResponse(recipes: [recipe])
        completion(.success(response))
    }

    func loadImage(with url: String, completion: @escaping (OperationCompletion<Data>) -> Void) {
        let imageData = UIImage(named: "defaultFoodImage", in: Bundle(for: type(of: self)), with: nil)
        completion(.success(imageData!.pngData()!))
    }

    func cancelImageLoad(with url: String) {}
}
