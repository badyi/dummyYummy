//
//  FridgeAssemblyProtocol.swift
//  dummyYummy
//
//  Created by badyi on 29.07.2021.
//

import Foundation

protocol FridgeAssemblyProtocol {

    /// Create searchResult flow
    /// - Parameters:
    ///   - ingredients: ingredients
    ///   - navigationDelegate: navigation delegate
    func createSearchResultModule(_ ingredients: [String],
                                  _ navigationDelegate: FridgeNavigationDelegate) -> FridgeSearchResultViewController

    /// create fridge flow
    /// - Parameter navigationDelegate: navigation delegate
    func createFridgeModule(_ navigationDelegate: FridgeNavigationDelegate)
}
