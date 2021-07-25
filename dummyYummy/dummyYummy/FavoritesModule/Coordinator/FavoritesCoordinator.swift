//
//  FavoritesCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType = .favorite

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFavorite()
    }

    func showFavorite() {
        let favoriteViewController = FavoritesViewController()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()

        let presenter = FavoritesPresenter(with: favoriteViewController, dataBaseService, fileSystemService)
        presenter.navigationDelegate = self
        favoriteViewController.presenter = presenter
        navigationController.pushViewController(favoriteViewController, animated: true)
    }

    func showDetail(with recipe: Recipe) {
        let detailViewController = DetailViewController()
        let networkService = DetailNetworkService()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()
        let presenter = DetailPresenter(with: detailViewController,
                                        dataBaseService,
                                        fileSystemService,
                                        networkService,
                                        recipe)

        detailViewController.presenter = presenter

        detailViewController.definesPresentationContext = true
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func showErrorAlert(with text: String) {

    }
}

extension FavoritesCoordinator: RecipesViewNavigationDelegate {
    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
