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
}

protocol FeedPresenterProtocol: AnyObject {
    init (with service: FeedServiceProtocol)
    func viewDidLoad()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayCell(at index: IndexPath)
    func recipesCount() -> Int
    func recipe(at index: IndexPath) -> FeedRecipe?
}
