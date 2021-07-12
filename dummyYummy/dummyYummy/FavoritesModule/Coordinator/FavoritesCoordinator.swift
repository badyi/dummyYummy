//
//  FavoritesCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

protocol FavoritesCoordinatorProtocol: Coordinator {
    
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .favorite
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
