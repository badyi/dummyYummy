//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailNetworkServiceProtocol: NetworkServiceProtocol {

    /// Load information about recipe
    /// - Parameters:
    ///   - id: id of recipe
    ///   - completion: result of loading
    func loadRecipeInfo(_ id: Int, completion: @escaping(OperationCompletion<RecipeInfoResponse>) -> Void)

    /// Load image
    /// - Parameters:
    ///   - url: url of image
    ///   - completion: result of loading
    func loadImage(_ url: String, completion: @escaping(OperationCompletion<Data>) -> Void)
}

protocol DetailResourceFactoryProtocol: ResourceFactoryProtocol {

    /// Create resource for loading
    /// - Parameter id: id of recipe
    func createRecipesInfoResource(_ id: Int) -> Resource<RecipeInfoResponse>?
}
