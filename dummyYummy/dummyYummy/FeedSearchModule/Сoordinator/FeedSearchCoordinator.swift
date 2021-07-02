//
//  FeedCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

protocol FeedSearchCoordinatorProtocol: Coordinator {
    func showFeedSearch()
}

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
        let feedPresenter = FeedPresenter(with: feedNetworkService)
        let feedViewController = FeedViewController(with: feedPresenter)
        feedPresenter.view = feedViewController
        
        let searchNetworkService = SearchNetworkService()
        let searchPresenter = SearchPresenter(with: searchNetworkService)
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
        searchController.searchBar.setImage(FeedSearchConstants.Image.searchSettingsButtonImage, for: .bookmark, state: .normal)
        
        feedViewController.navigationItem.searchController = searchController
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
}

extension FeedSearchCoordinator: SearchNavigationDelegate {
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements) {
        let presenter = RefinementsPresenter(with: currentRefinements)
        let settings = RefinementsViewController(with: presenter)
        presenter.view = settings
        settings.hidesBottomBarWhenPushed = true
        settings.willFinish = { [weak self] refinements in
            guard let searchReslutVC = (self?.navigationController.visibleViewController as? FeedViewController)?.navigationItem.searchController?.searchResultsController as? SearchResultViewController else {
                return
            }
            searchReslutVC.presenter.updateRefinements(refinements)
        }
        navigationController.pushViewController(settings, animated: true)
    }
}
