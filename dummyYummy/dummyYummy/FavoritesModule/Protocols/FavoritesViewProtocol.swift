//
//  FavoritesViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol FavoritesViewProtocol: RecipesViewProtocol {
    func setupView()
    func reloadCollection()
}
