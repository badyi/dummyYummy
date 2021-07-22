//
//  SearchProtocols.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

protocol SearchNetworkServiceProtocol: NetworkServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> Void)
    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)

    func cancelImageLoad(with url: String)
    func cancelCurrenSearch()
    func cancelLoadAllImages()
}

protocol SearchResourceFactoryProtocol: ResourceFactoryProtocol {
    func createSearchRecipesResource(_ query: String) -> Resource<SearchResponse>?
}
