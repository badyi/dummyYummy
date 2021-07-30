//
//  FeedSearchAssembly.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

protocol FeedSearchAssemblyProtocol {
    func createFeedSearchModule(_ recipesNavigationDelegate: RecipesViewNavigationDelegate,
                                _ searchNavigationDelegate: SearchNavigationDelegate) -> FeedViewController
}

final class FeedSearchAssembly: FeedSearchAssemblyProtocol {
    func createFeedSearchModule(_ recipesNavigationDelegate: RecipesViewNavigationDelegate,
                                _ searchNavigationDelegate: SearchNavigationDelegate) -> FeedViewController {

        let feedNetworkService = FeedNetworkService()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()

        let feedViewController = FeedViewController()
        let feedPresenter = FeedPresenter(with: feedViewController,
                                          feedNetworkService,
                                          dataBaseService,
                                          fileSystemService)

        feedViewController.presenter = feedPresenter
        feedPresenter.navigationDelegate = recipesNavigationDelegate

        let searchNetworkService = SearchNetworkService()
        let searchResultViewController = SearchResultViewController()
        let searchPresenter = SearchPresenter(with: searchResultViewController, searchNetworkService)

        searchPresenter.navigationDelegate = searchNavigationDelegate
        searchResultViewController.presenter = searchPresenter

        let searchController = UISearchController(searchResultsController: searchResultViewController)

        searchController.searchResultsUpdater = searchResultViewController
        searchController.searchBar.delegate = searchResultViewController

        feedViewController.setSearchController(searchController)

        return feedViewController
    }
}
