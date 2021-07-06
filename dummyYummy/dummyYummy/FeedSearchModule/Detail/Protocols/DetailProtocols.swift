//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setupView()
}

protocol DetailPresenterProtocol {
    var recipe: FeedRecipe { get }
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: FeedRecipe)
    
    func headerTitle() -> String
}

protocol DetailNetworkServiceProtocol {
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
}
