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
        let feedNetworkService = FeedNetworkService()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()

        let feedViewController = FeedViewController()
        let feedPresenter = FeedPresenter(with: feedViewController,
                                          feedNetworkService,
                                          dataBaseService,
                                          fileSystemService)

        feedViewController.presenter = feedPresenter
        feedPresenter.view = feedViewController
        feedPresenter.navigationDelegate = self

        let searchNetworkService = SearchNetworkService()
        let searchResultViewController = SearchResultViewController()
        let searchPresenter = SearchPresenter(with: searchResultViewController, searchNetworkService)

        searchPresenter.navigationDelegate = self
        searchResultViewController.presenter = searchPresenter

        let searchController = UISearchController(searchResultsController: searchResultViewController)

        searchController.searchResultsUpdater = searchResultViewController
        searchController.searchBar.delegate = searchResultViewController
        feedViewController.setSearchController(searchController)

        navigationController.pushViewController(feedViewController, animated: true)
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
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}

extension FeedSearchCoordinator: SearchNavigationDelegate {

    func searchDidTapCell(with recipe: Recipe) {
        showDetail(with: recipe)
    }
}

extension FeedSearchCoordinator: RecipesViewNavigationDelegate {
    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
