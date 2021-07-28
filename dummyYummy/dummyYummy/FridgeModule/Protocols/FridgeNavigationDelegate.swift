//
//  FridgeNavigationDelegate.swift
//  dummyYummy
//
//  Created by badyi on 27.07.2021.
//

import Foundation

protocol FridgeNavigationDelegate: RecipesViewNavigationDelegate {
    func didTapSearch(_ ingredients: [String])
    func activity(with url: String)
    func error(with description: String)
}
