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
        if isFirstLaunch() {
            showGuide()
        } else {
            showMainFlow()
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
    private func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let key = "isFirstLaunchFlag"
        if defaults.bool(forKey: key) == true {
            defaults.setValue(true, forKey: key)
            return false
        } else {
            defaults.setValue(true, forKey: key)
            return true
        }
    }
}

extension AppCoordinator: GuideNavigationDelegate {
    func finishGuide() {
        showMainFlow()
    }
}
