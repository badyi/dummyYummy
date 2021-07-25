//
//  AppCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

// Define what type of flows can be started from this Coordinator
protocol AppCoordinatorProtocol: Coordinator {
    func showMainFlow()
}

final class AppCoordinator: AppCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators = [Coordinator]()

    var type: CoordinatorType { .app }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showMainFlow()
    }

    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        if childCoordinator.type == .tab {
            navigationController.viewControllers.removeAll()
        }
    }
}
