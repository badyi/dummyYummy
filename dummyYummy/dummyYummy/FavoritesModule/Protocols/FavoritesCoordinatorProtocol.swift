//
//  FavoritesCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol FavoritesCoordinatorProtocol: Coordinator {
    func showFavorite()
    func showDetail(with recipe: Recipe)
}
