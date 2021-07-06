//
//  DetailPresenter.swift
//  dummyYummy
//
//  Created by badyi on 05.07.2021.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewProtocol?
    var networkService: DetailNetworkServiceProtocol
    var recipe: FeedRecipe
    
    init(with view: DetailViewProtocol, _ networkService: DetailNetworkServiceProtocol, _ recipe: FeedRecipe) {
        self.view = view
        self.recipe = recipe
        self.networkService = networkService
    }
    
    func headerTitle() -> String {
        return recipe.title
    }
    
}
