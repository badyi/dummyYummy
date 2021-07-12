//
//  SearchProtocols.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    
    func setupView()
    func reloadCollection()
    func reloadItems(at indexPaths: [IndexPath])
    func configNavigation()
}

protocol SearchPresenterProtocol: AnyObject {
    var refinements: SearchRefinements { get }
    
    init (with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol)
    
    func viewDidLoad()
    func viewWillAppear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayCell(at index: IndexPath)
    func didSelectCell(at index: IndexPath)
    func updateRefinements(_ refinements: SearchRefinements)
    func resultCount() -> Int
    func updateSearchResult(_ query: String)
    func searchRefinementsTapped()
}

protocol SearchNetworkServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> ())
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
}

protocol SearchNavigationDelegate {
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements)
    func searchDidTapCell(with recipe: FeedRecipe)
}
