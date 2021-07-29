//
//  FridgeAssembly.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

protocol FridgeAssemblyProtocol {
    func createSearchResultModule(_ ingredients: [String],
                                  _ navigationDelegate: FridgeNavigationDelegate) -> FridgeSearchResultViewController

    func createFridgeModule(_ navigationDelegate: FridgeNavigationDelegate)
}

final class FridgeAssembly {
    func createSearchResultModule(_ ingredients: [String],
                                  _ navigationDelegate: FridgeNavigationDelegate) -> FridgeSearchResultViewController {

        let service = FridgeSearchNetworkService()
        let view = FridgeSearchResultViewController()
        let presenter = FridgeSearchResultPresenter(with: view, service, ingredients.reversed())
        presenter.navigationDelegate = navigationDelegate
        view.presenter = presenter

        return view
    }

    func createFridgeModule(_ navigationDelegate: FridgeNavigationDelegate) -> FridgeViewController {

        let fridgeView = FridgeViewController()
        let presenter = FridgePresenter(with: fridgeView)
        presenter.navigationDelegate = navigationDelegate
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

        return fridgeView
    }
}
