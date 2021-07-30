//
//  FridgeCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class FridgeCoordinator: FridgeCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType { .fridge }

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFridge()
    }

    func showFridge() {
        let fridgeVC = FridgeAssembly().createFridgeModule(self)
        navigationController.pushViewController(fridgeVC, animated: true)
    }

    func showSearchResult(_ ingredients: [String]) {
        let searchResultVC = FridgeAssembly().createSearchResultModule(ingredients, self)
        navigationController.pushViewController(searchResultVC, animated: true)
    }

    func showDetail(with recipe: Recipe) {
        let detailCoordinator = DetailCoordinator(navigationController)
        childCoordinators.append(detailCoordinator)

        detailCoordinator.finishDelegate = self
        detailCoordinator.recipe = recipe
        detailCoordinator.start()
    }
}

extension FridgeCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        if let childCoordinator = childCoordinators.last, childCoordinator.type == .detail {
            navigationController.popToRootViewController(animated: true)
            childCoordinators.removeLast()
        }
    }
}

extension FridgeCoordinator: FridgeNavigationDelegate {
    func activity(with url: String) {
        showActivity(with: url)
    }

    func didTapSearch(_ ingredients: [String]) {
        showSearchResult(ingredients)
    }

    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
