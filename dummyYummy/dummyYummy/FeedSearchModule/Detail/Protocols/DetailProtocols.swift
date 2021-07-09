//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setupView()
    func reloadSection(_ section: Int)
}

protocol DetailPresenterProtocol {
    var recipe: FeedRecipe { get }
    
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: FeedRecipe)
    func viewDidLoad()
    func viewWillAppear()
    func headerTitle() -> String
    func headerTapped(_ section: Int)
}

protocol DetailNetworkServiceProtocol {
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
}
