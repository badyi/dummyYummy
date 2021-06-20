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
        let service = FeedService()
        let presenter = FeedPresenter(with: service)
        let feedViewController = FeedViewController(with: presenter)
        presenter.view = feedViewController
        feedViewController.title = "Browes food"
        feedViewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: SearchViewController())
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        feedViewController.navigationController?.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = UIColor(hexString: "#121212")
        navigationController.navigationBar.barTintColor = UIColor(hexString: "#121212")
        navigationController.navigationBar.tintColor = Colors.wisteria
        navigationController.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.wisteria]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        
        feedViewController.navigationItem.hidesSearchBarWhenScrolling = false
        feedViewController.navigationItem.searchController = searchController
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
}
