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
    init (with service: SearchServiceProtocol)
    func viewDidLoad()
    func viewWillAppear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayCell(at index: IndexPath)
//    func recipesCount() -> Int
//    func recipe(at index: IndexPath) -> FeedRecipe?
}

protocol SearchServiceProtocol {
    
}

protocol SearchNavigationDelegate {
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements)
}
