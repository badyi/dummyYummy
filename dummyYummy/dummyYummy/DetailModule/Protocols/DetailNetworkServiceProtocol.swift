//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailNetworkServiceProtocol: NetworkServiceProtocol {
    func loadRecipeInfo(_ id: Int, completion: @escaping(OperationCompletion<RecipeInfoResponse>) -> Void)
    func loadImage(_ url: String, completion: @escaping(OperationCompletion<Data>) -> Void)
}

protocol DetailResourceFactoryProtocol: ResourceFactoryProtocol {
    func createRecipesInfoResource(_ id: Int) -> Resource<RecipeInfoResponse>?
}
