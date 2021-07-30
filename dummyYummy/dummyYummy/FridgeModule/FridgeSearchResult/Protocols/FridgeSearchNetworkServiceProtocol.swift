//
//  FridgeSearchNetworkServiceProtocol.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import Foundation

protocol FridgeSearchNetworkServiceProtocol: NetworkServiceProtocol {
    func loadRecipes(_ ingredients: [String], _ count: Int,
                     completion: @escaping(OperationCompletion<[SearchResult]>) -> Void)
    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void)
    func cancelLoadImage(with url: String)
}
