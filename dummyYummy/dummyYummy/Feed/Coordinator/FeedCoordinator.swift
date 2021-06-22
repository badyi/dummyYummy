//
//  FeedCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

protocol FeedCoordinatorProtocol: Coordinator {
    func showFeedViewController()
}

final class FeedCoordinator: FeedCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .feed }
    
    func start() {
        showFeedViewController()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showFeedViewController() {
        let feedService = FeedService()
        let feedPresenter = FeedPresenter(with: feedService)
        let feedViewController = FeedViewController(with: feedPresenter)
        feedPresenter.view = feedViewController

        let searchService = SearchService()
        let searchPresenter = SearchPresenter(with: searchService)
        let result = SearchViewController(with: searchPresenter)
        searchPresenter.view = result
        
        let searchController = UISearchController(searchResultsController: result)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = result
        
        feedViewController.navigationItem.searchController = searchController
        //result.delegate = feedViewController
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
}
