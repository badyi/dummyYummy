//
//  Coordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

enum TabBarPage {
    case feed
    case fridge
    case favorites

    init?(index: Int) {
        switch index {
        case 0:
            self = .feed
        case 1:
            self = .fridge
        case 2:
            self = .favorites
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .feed:
            return "Feed"
        case .fridge:
            return "Fridge"
        case .favorites:
            return "Favorites"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .feed:
            return 0
        case .fridge:
            return 1
        case .favorites:
            return 2
        }
    }

    // Add tab icon value

    // Add tab icon selected / deselected color

    // etc
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)

    func setSelectedIndex(_ index: Int)

    func currentPage() -> TabBarPage?
}

final class TabCoordinator: NSObject, Coordinator {
   // weak var finishDelegate: CoordinatorFinishDelegate?

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        // Define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.feed, .fridge, .favorites]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        // Set delegate for UITabBarController
        tabBarController.delegate = self
        // Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        // Set index
        tabBarController.selectedIndex = TabBarPage.feed.pageOrderNumber()
        // Styling
        tabBarController.tabBar.isTranslucent = false

        // In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .feed:
            let feedSearchCoordinator = FeedSearchCoordinator(navController)
            feedSearchCoordinator.start()
            childCoordinators.append(feedSearchCoordinator)
        case .fridge:
            let fridgeCoordinator = FridgeCoordinator(navController)
            fridgeCoordinator.start()
            childCoordinators.append(fridgeCoordinator)
        case .favorites:
            let favoritesCoodrinator = FavoritesCoordinator(navController)
            favoritesCoodrinator.start()
            childCoordinators.append(favoritesCoodrinator)
        }

        return navController
    }

    func currentPage() -> TabBarPage? { TabBarPage(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}
