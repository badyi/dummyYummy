//
//  FeedNetworkDelegate.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FeedNetworkServiceProtocol: NetworkServiceProtocol {

    func clearAndCancelAll()

    /// Load random recipes from api
    /// - Parameters:
    ///   - count: count of recipes
    ///   - completion: number of recipes to download
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<RecipesResponse>) -> Void)

    /// Load image
    /// - Parameters:
    ///   - indexPath: the index of the cell that asks to download the image
    ///   - url: url of image
    ///   - completion: result of downloading
    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)

    /// Cancel request at index
    /// - Parameter index: the index of the cell that asked to download the image
    func cancelImageLoad(with url: String)
}

protocol FeedResourceFactoryProtocol: ResourceFactoryProtocol {
    func createRandomRecipesResource(_ count: Int) -> Resource<RecipesResponse>?
}
