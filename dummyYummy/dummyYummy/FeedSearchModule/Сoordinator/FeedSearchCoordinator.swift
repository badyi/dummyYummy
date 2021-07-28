//
//  FeedCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedSearchCoordinator: FeedSearchCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .feedSearch }

    func start() {
        showFeedSearch()
    }

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showFeedSearch() {
        let feedSearchVC = FeedSearchAssembly().createFeedSearchModule(self, self)

        navigationController.pushViewController(feedSearchVC, animated: true)
    }

    func showDetail(with recipe: Recipe) {
        let detailCoordinator = DetailCoordinator(navigationController)
        childCoordinators.append(detailCoordinator)

        detailCoordinator.finishDelegate = self
        detailCoordinator.recipe = recipe
        detailCoordinator.start()
    }
}

extension FeedSearchCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        if let childCoordinator = childCoordinators.last, childCoordinator.type == .detail {
            navigationController.popToRootViewController(animated: true)
            childCoordinators.removeLast()
        }
    }
}

extension FeedSearchCoordinator: SearchNavigationDelegate {

    func searchDidTapCell(with recipe: Recipe) {
        showDetail(with: recipe)
    }
}

extension FeedSearchCoordinator: RecipesViewNavigationDelegate {
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
