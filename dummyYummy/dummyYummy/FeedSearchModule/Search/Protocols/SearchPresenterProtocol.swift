//
//  SearchPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

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
