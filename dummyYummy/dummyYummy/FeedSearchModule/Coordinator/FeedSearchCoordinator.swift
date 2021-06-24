//
//  FeedCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

protocol FeedSearchCoordinatorProtocol: Coordinator {
    func showFeedSearchViewController()
}

final class FeedSearchCoordinator: FeedSearchCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .feed }
    
    func start() {
        showFeedSearchViewController()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showFeedSearchViewController() {
        let feedService = FeedService()
        let feedPresenter = FeedPresenter(with: feedService)
        let feedViewController = FeedViewController(with: feedPresenter)
        feedPresenter.view = feedViewController

        let searchService = SearchService()
        let searchPresenter = SearchPresenter(with: searchService)
        let result = SearchResultViewController(with: searchPresenter)
        result.navigationDelegate = self
        searchPresenter.view = result
        
        let searchController = UISearchController(searchResultsController: result)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = result
        searchController.searchBar.delegate = result
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(FeedSearchConstants.searchSettingsButtonImage, for: .bookmark, state: .normal)
        
        feedViewController.navigationItem.searchController = searchController
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
}

extension FeedSearchCoordinator: SearchNavigationDelegate {
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements) {
        let view = RefinementsView()
        let settings = RefinementsViewController(with: view, currentRefinements)
        settings.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(settings, animated: true)
    }
}
