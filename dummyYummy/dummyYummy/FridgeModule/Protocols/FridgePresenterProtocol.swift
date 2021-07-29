//
//  FridgePresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FridgePresenterProtocol {
    init (with view: FridgeViewProtocol)

    func ingredientsCount() -> Int
    func setChosenIngredients(_ ingredients: [String])
    func title(at index: Int) -> String
    func delete(at index: Int)
    func didTapSearchButton()
}
