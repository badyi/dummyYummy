//
//  SearchIngredientsPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol SearchIngredientsPresenterProtocol {
    var chosenIngredinets: [String] { get }

    init(with view: SearchIngredientsViewProtocol,
         _ networkService: SearchIngredientsNetworkProtocol)

    func reloadTable()
    func didSelectRecipe(at index: Int)
    func title(at index: Int) -> String
    func ingredientsCount() -> Int
    func isChosen(_ ingredient: String) -> Bool
    func handleChooseTap(at ingredient: String)
    func loadSearch(_ query: String)
    func setChosenIngredients(_ ingredients: [String])
}
