//
//  FavoritesCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol FavoritesCoordinatorProtocol: Coordinator {

    /// Show favoite flow
    func showFavorite()

    /// Show detail flow
    /// - Parameter recipe: recipe for detail
    func showDetail(with recipe: Recipe)
}
