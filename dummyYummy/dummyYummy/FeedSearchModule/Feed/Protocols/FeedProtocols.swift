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
    func configNavigation()
    
    func reloadCollection()
    func reloadItems(at indexPaths: [IndexPath])
    
    /// need this method to stop
    /// animtion in visible cells when new view controller is pushed
    func stopVisibleCellsAnimation()
    
    /// need this method in case
    /// cells with animation were stopped by pushing a new view controller
    /// and we need to restore the animation
    func reloadVisibleCells()
}

protocol FeedPresenterProtocol: AnyObject {
    init (with networkService: FeedServiceProtocol)
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayingCell(at index: IndexPath)
    func recipe(at index: IndexPath) -> FeedRecipe?
}

protocol FeedServiceProtocol {
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<FeedRecipeResponse>) -> ())
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
    func cancelRequest(at index: IndexPath)
}
