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

    func willDisplayRecipe(at index: Int)
    func didEndDisplayRecipe(at index: Int)
    func didSelectRecipe(at index: Int)
    func updateRefinements(_ refinements: SearchRefinements)
    func loadRecipes(with query: String)
    func searchRefinementsTapped()

    func recipesCount() -> Int
    func recipe(at index: Int) -> Recipe?
}
