//
//  FavoritesAssembly.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

protocol FavoritesAssemblyProtoocl {
    func createFavoritesModule(_ navigationDelegate: FavoritesNavigationDelegate) -> FavoritesViewController
}

final class FavoritesAssembly {
    func createFavoriteModule(_ navigationDelegate: FavoritesNavigationDelegate) -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()

        let presenter = FavoritesPresenter(with: favoritesViewController, dataBaseService, fileSystemService)
        presenter.navigationDelegate = navigationDelegate
        favoritesViewController.presenter = presenter

        return favoritesViewController
    }
}
