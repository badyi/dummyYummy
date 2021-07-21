//
//  SearchIngredientsNetworkProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol SearchIngredientsNetworkProtocol: NetworkServiceProtocol {
    func loadIngredients(_ count: Int,
                         _ query: String,
                         completion: @escaping(OperationCompletion<IngredientsResponse>) -> Void)
}

protocol SearchIngredientsResourceFactoryProtocol: ResourceFactoryProtocol {
    func createIngredientsResource(_ count: Int, _ query: String) -> Resource<IngredientsResponse>?
}
