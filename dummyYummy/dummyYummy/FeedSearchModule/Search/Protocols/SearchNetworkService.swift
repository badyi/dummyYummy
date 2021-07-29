//
//  SearchProtocols.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

protocol SearchNetworkServiceProtocol: NetworkServiceProtocol {

    /// Load search task
    /// - Parameters:
    ///   - query: query for searching
    ///   - completion: result of load
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> Void)

    /// Load image
    /// - Parameters:
    ///   - url: url of image
    ///   - completion: result of load
    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)

    /// Cancel image load
    /// - Parameter url: url of image
    func cancelImageLoad(with url: String)

    /// Cancel current search task
    func cancelCurrenSearch()

    /// Cancel loading of all images
    func cancelLoadAllImages()
}

protocol SearchResourceFactoryProtocol: ResourceFactoryProtocol {
    func createSearchRecipesResource(_ query: String) -> Resource<SearchResponse>?
}
