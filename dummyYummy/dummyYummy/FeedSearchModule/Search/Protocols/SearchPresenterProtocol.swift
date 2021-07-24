//
//  SearchPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {

    init (with view: SearchViewProtocol, _ networkService: SearchNetworkServiceProtocol)

    func willDisplayRecipe(at index: Int)
    func didEndDisplayRecipe(at index: Int)
    func didSelectRecipe(at index: Int)
    func loadRecipes()
    func updateSearchText(_ query: String)

    func recipesCount() -> Int
    func recipe(at index: Int) -> Recipe?
}
