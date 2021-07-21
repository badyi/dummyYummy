//
//  SearchProtocols.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

protocol SearchNetworkServiceProtocol: NetworkServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> Void)
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)
}

protocol SearchResourceFactoryProtocol: ResourceFactoryProtocol {
    func createSearchRecipesResource(_ query: String) -> Resource<SearchResponse>?
}
