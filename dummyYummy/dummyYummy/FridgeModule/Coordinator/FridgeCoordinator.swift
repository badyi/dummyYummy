//
//  FridgeCoordinator.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class FridgeCoordinator: FridgeCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType { .fridge }

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
        presenter.navigationDelegate = self
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

    func showSearchResult(_ ingredients: [String]) {
        let service = FridgeSearchNetworkService()
        let view = FridgeSearchResultViewController()
        let presenter = FridgeSearchResultPresenter(with: view, service, ingredients)
        presenter.navigationDelegate = self
        view.presenter = presenter

        navigationController.pushViewController(view, animated: true)
    }

    func showDetail(with recipe: Recipe) {
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

        detailViewController.definesPresentationContext = true
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension FridgeCoordinator: FridgeNavigationDelegate {
    func activity(with url: String) {
        showActivity(with: url)
    }

    func didTapSearch(_ ingredients: [String]) {
        showSearchResult(ingredients)
    }

    func error(with description: String) {
        showErrorAlert(with: description)
    }

    func didTapRecipe(_ recipe: Recipe) {
        showDetail(with: recipe)
    }
}
