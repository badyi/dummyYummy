//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setupView()
    func configNavigationBar()
    func reloadSection(_ section: Int)
    func reloadCollection()
}

protocol DetailPresenterProtocol {
    var recipe: Recipe { get }
    
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: Recipe)
    func viewDidLoad()
    func viewWillAppear()
    func headerTitle() -> String
    func ingredientTitle(at indexPath: IndexPath) -> String
    func instructionTitle(at indexPath: IndexPath) -> String
    func characteristic(at indexPath: IndexPath) -> String
    func currentSelectedSegment() -> Int
    func headerTapped(_ section: Int)
}

protocol DetailNetworkServiceProtocol {
    func loadRecipeInfo(_ id: Int, completion: @escaping(OperationCompletion<FeedRecipeInfoResponse>) -> ())
    func loadImage(_ url: String, completion: @escaping(OperationCompletion<Data>) -> ())
}
