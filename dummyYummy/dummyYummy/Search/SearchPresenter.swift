//
//  SearchPresenter.swift
//  dummyYummy
//
//  Created by badyi on 22.06.2021.
//

import UIKit

final class SearchPresenter {
    weak var view: SearchViewProtocol?
    var service: SearchServiceProtocol
    //var recipes: [FeedRecipe]
    //private let randomRecipesCount: Int = 100
    
    required init(with service: SearchServiceProtocol) {
        self.service = service
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewWillAppear() {
        view?.configNavigation()
    }
    
    func willDisplayCell(at index: IndexPath) {
        
    }
    
    func didEndDisplayCell(at index: IndexPath) {
        
    }
}
