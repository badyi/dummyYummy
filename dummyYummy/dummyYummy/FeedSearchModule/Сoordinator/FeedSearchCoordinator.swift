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
        let feedViewController = FeedViewController()
        let feedPresenter = FeedPresenter(with: feedViewController, feedNetworkService)
        
        feedViewController.presenter = feedPresenter
        feedPresenter.view = feedViewController
        feedPresenter.navigationDelegate = self
        
        let searchNetworkService = SearchNetworkService()
        let searchResultViewController = SearchResultViewController()
        let searchPresenter = SearchPresenter(with: searchResultViewController, searchNetworkService)
        
        searchPresenter.navigationDelegate = self
        searchResultViewController.presenter = searchPresenter
        
        searchPresenter.view = searchResultViewController
        
        let searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = searchResultViewController
        searchController.searchBar.delegate = searchResultViewController
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(FeedSearchConstants.Image.searchSettingsButtonImage, for: .bookmark, state: .normal)
        
        feedViewController.navigationItem.searchController = searchController
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
    
    func showRefinements(with refinements: SearchRefinements) {
        let refinementsViewController = RefinementsViewController()
        let presenter = RefinementsPresenter(with: refinements)
        
        refinementsViewController.presenter = presenter
        presenter.view = refinementsViewController
        
        refinementsViewController.hidesBottomBarWhenPushed = true
        refinementsViewController.willFinish = { [weak self] refinements in
            guard let searchReslutVC = (self?.navigationController.visibleViewController as? FeedViewController)?.navigationItem.searchController?.searchResultsController as? SearchResultViewController else {
                return
            }
            searchReslutVC.presenter.updateRefinements(refinements)
        }
        navigationController.pushViewController(refinementsViewController, animated: true)
    }
    
    func showDetail(with recipe: FeedRecipe) {
        let detailViewController = DetailViewController()
        let networkService = DetailNetworkService()
        let presenter = DetailPresenter(with: detailViewController, networkService, recipe)
        
        detailViewController.presenter = presenter
        
        detailViewController.definesPresentationContext = true
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension FeedSearchCoordinator: SearchNavigationDelegate {
    
    func searchDidTapCell() {
        #warning("didtap")
    }
    
    func didTapSearchSettingsButton(_ currentRefinements: SearchRefinements) {
        showRefinements(with: currentRefinements)
    }
}

extension FeedSearchCoordinator: FeedNavigationDelegate {
    func feedDidTapCell(with recipe: FeedRecipe) {
        showDetail(with: recipe)
    }
}
