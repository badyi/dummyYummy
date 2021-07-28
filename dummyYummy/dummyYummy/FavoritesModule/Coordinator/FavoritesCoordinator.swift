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
        let favoritesVC = FavoritesAssembly().createFavoriteModule(self)
        navigationController.pushViewController(favoritesVC, animated: true)
    }

    func showDetail(with recipe: Recipe) {
        let detailCoordinator = DetailCoordinator(navigationController)
        childCoordinators.append(detailCoordinator)

        detailCoordinator.finishDelegate = self
        detailCoordinator.recipe = recipe
        detailCoordinator.start()
    }
}

extension FavoritesCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        if let childCoordinator = childCoordinators.last, childCoordinator.type == .detail {
            navigationController.popToRootViewController(animated: true)
            childCoordinators.removeLast()
        }
    }
}

extension FavoritesCoordinator: FavoritesNavigationDelegate {
    func activity(with url: String) {
        showActivity(with: url)
    }

    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
