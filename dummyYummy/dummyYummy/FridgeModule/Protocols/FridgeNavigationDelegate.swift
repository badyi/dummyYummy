//
//  FridgeNavigationDelegate.swift
//  dummyYummy
//
//  Created by badyi on 27.07.2021.
//

import Foundation

protocol FridgeNavigationDelegate: RecipesViewNavigationDelegate {

    /// Handle tap on search button
    /// - Parameter ingredients: ingredients
    func didTapSearch(_ ingredients: [String])
}
