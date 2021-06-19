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
        
        navigationController.pushViewController(feedViewController, animated: true)
        
    }
}
