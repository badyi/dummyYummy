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
    func showGuide()
}

final class AppCoordinator: AppCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators = [Coordinator]()

    var type: CoordinatorType { .app }

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        if hasBeenLaunchdBefore() {
            showMainFlow()
        } else {
            showGuide()
        }
    }

    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }

    func showGuide() {
        let pageController = AppAssembly().createGuideModule(navigationDelegate: self)

        navigationController.pushViewController(pageController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        if childCoordinator.type == .tab {
            navigationController.viewControllers.removeAll()
        }
    }
}

extension AppCoordinator {
    private func hasBeenLaunchdBefore() -> Bool {
        let defaults = UserDefaults.standard
        let key = "hasBeenLaunchdBeforeFlag"
        if defaults.bool(forKey: key) == true {
            return true
        } else {
            defaults.setValue(true, forKey: key)
            return false
        }
    }
}

extension AppCoordinator: GuideNavigationDelegate {
    func finishGuide() {
        showMainFlow()
    }
}
