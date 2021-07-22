//
//  FridgeCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class FridgeCoordinator: FridgeCoordinatorProtocol {
    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType = .fridge

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFridge()
    }

    func showFridge() {
        let fridgeView = FridgeViewController()
        let networkService = FridgeNetworkService()
        let presenter = FridgePresenter(with: fridgeView, networkService)
        fridgeView.presenter = presenter

        let searchResult = SearchIngredientsViewController()
        let searchService = SearchIngredientsNetworkService()
        let searchPresenter = SearchIngredientsPresenter(with: searchResult, searchService)

        searchResult.presenter = searchPresenter

        let searchController = UISearchController(searchResultsController: searchResult)

        searchController.searchResultsUpdater = searchResult

        fridgeView.setupSearchController(searchController)

        searchResult.willAppear = {
            searchPresenter.setChosenIngredients(presenter.chosenIngredients)
        }

        searchResult.willFinish = { ingredients in
            guard let ingredients = ingredients else { return }
            presenter.setChosenIngredients(ingredients)
        }

        navigationController.pushViewController(fridgeView, animated: true)
    }
}

extension FridgeCoordinator {

}
