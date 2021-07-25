//
//  RecipeViewNavigationDelegate.swift
//  dummyYummy
//
//  Created by badyi on 25.07.2021.
//

import Foundation

protocol RecipesViewNavigationDelegate: AnyObject {

    /// Handle tap on specific recipe
    /// - Parameter recipe: selected recipe
    func didTapRecipe(_ recipe: Recipe)

    /// Recive error with text
    /// - Parameter description: text of error
    func error(with description: String)
}
