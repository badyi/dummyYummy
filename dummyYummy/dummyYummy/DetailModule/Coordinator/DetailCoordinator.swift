//
//  DetailCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 25.07.2021.
//

import UIKit

final class DetailCoordinator: DetailCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType { .detail }

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

        let detailVC = DetailAssembly().createDetailModule(recipe, self)
        detailVC.finishClosure = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(detailVC, animated: true)
    }
}

extension DetailCoordinator: DetailNavigationDelegate {
    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func share(with url: String) {
        showActivity(with: url)
    }
}
