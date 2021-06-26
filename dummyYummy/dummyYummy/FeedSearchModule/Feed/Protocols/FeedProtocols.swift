//
//  FeedProtocols.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import Foundation

protocol FeedViewProtocol: AnyObject {
    init(with presenter: FeedPresenterProtocol)
    func setupView()
    func reloadCollection()
    func reloadItems(at indexPaths: [IndexPath])
    func configNavigation()
    func stopCellsAnimation()
}

protocol FeedPresenterProtocol: AnyObject {
    init (with networkService: FeedServiceProtocol)
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayingCell(at index: IndexPath)
    //func recipesCount() -> Int
    func recipe(at index: IndexPath) -> FeedRecipe?
}

protocol FeedServiceProtocol {
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<FeedRecipeResponse>) -> ())
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
    func cancelRequest(at index: IndexPath)
}
