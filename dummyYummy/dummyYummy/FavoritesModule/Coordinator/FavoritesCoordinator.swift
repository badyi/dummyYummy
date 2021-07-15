//
//  FavoritesCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

protocol FavoritesCoordinatorProtocol: Coordinator {
    func showFavorite()
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
   // var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .favorite
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showFavorite()
    }
    
    func showFavorite() {
        let favoriteViewController = FavoritesViewController()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()
        
        let presenter = FavoritesPresenter(with: favoriteViewController, dataBaseService, fileSystemService)
        favoriteViewController.presenter = presenter
        navigationController.pushViewController(favoriteViewController, animated: true)
    }
}
