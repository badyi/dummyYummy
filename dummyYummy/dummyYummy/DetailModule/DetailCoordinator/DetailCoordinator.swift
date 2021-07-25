//
//  DetailCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 25.07.2021.
//

import UIKit

protocol DetailCoordinatorProtocol: Coordinator {
    func showDetail()
}

final class DetailCoordinator: DetailCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType = .detail
    var recipe: Recipe?

    func start() {
        showDetail()
    }

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showDetail() {
        guard let recipe = recipe else {
            return
        }

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
        detailViewController.finishClosure = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
