//
//  FeedNetworkDelegate.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FeedServiceProtocol {

    /// Load random recipes from api
    /// - Parameters:
    ///   - count: count of recipes
    ///   - completion: number of recipes to download
    func loadRandomRecipes(_ count: Int, completion: ((OperationCompletion<FeedRecipeResponse>) -> Void)?)

    /// Load image
    /// - Parameters:
    ///   - indexPath: the index of the cell that asks to download the image
    ///   - url: url of image
    ///   - completion: result of downloading
    func loadImage(at indexPath: IndexPath, with url: String, completion: ((OperationCompletion<Data>) -> Void)?)

    /// Cancel request at index
    /// - Parameter index: the index of the cell that asked to download the image
    func cancelRequest(at indexPath: IndexPath)
}
