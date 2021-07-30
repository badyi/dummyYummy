//
//  FavoritesAssemblyProtocol.swift
//  dummyYummy
//
//  Created by badyi on 30.07.2021.
//

import Foundation

protocol FavoritesAssemblyProtoocl {

    /// Create favorites module
    /// - Parameter navigationDelegate: navigation delegate
    func createFavoritesModule(_ navigationDelegate: FavoritesNavigationDelegate) -> FavoritesViewController
}
