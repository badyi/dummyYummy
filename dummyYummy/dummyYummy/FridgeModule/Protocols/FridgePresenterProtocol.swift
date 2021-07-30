//
//  FridgePresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FridgePresenterProtocol {
    init (with view: FridgeViewProtocol)

    /// Count of all ingredients
    func ingredientsCount() -> Int

    /// Set chosen ingredients
    /// - Parameter ingredients: array of ingredients
    func setChosenIngredients(_ ingredients: [String])

    /// Get title at index
    /// - Parameter index: index of ingredient
    func title(at index: Int) -> String

    /// Delete ingredient at index
    /// - Parameter index: index of ingredinet
    func delete(at index: Int)

    /// Search button was tapped
    func didTapSearchButton()
}
