//
//  FridgePresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol FridgePresenterProtocol {
    init (with view: FridgeViewProtocol, _ networkService: FridgeNetworkServiceProtocol)

    func setChosenIngredients(_ ingredients: [String])
}
