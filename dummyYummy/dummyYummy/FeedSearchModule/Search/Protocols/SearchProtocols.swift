//
//  SearchProtocols.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    init(with presenter: SearchPresenterProtocol)
    func setupView()
    func reloadCollection()
    func reloadItems(at indexPaths: [IndexPath])
    func configNavigation()
}

protocol SearchPresenterProtocol: AnyObject {
    var refinements: SearchRefinements { get }
    init (with networkService: SearchServiceProtocol)
    func viewDidLoad()
    func viewWillAppear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayCell(at index: IndexPath)
    func updateRefinements(_ refinements: SearchRefinements)
    func resultCount() -> Int
    func updateSearchResult(_ query: String)
//    func recipe(at index: IndexPath) -> FeedRecipe?
}

protocol SearchServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> ())
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
}

protocol SearchNavigationDelegate {
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements)
}
