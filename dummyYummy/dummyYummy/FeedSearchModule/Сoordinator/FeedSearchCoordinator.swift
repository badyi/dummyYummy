//
//  FeedCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

protocol FeedSearchCoordinatorProtocol: Coordinator {
    func showFeedSearch()
    func showDetail(with recipe: Recipe)
}

final class FeedSearchCoordinator: FeedSearchCoordinatorProtocol {
    // var finishDelegate: CoordinatorFinishDelegate?
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
}

extension FeedSearchCoordinator: SearchNavigationDelegate {

    func searchDidTapCell(with recipe: Recipe) {
        showDetail(with: recipe)
    }
}

extension FeedSearchCoordinator: RecipesNavigationDelegate {
    func showErrorAlert(with text: String) {
        #warning("eroro")
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
