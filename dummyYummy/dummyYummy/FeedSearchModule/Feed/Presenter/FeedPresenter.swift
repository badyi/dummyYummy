//
//  FeedPresenter.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import Foundation

final class FeedPresenter {
    weak var view: FeedViewProtocol?
    var service: FeedServiceProtocol
    var recipes: [FeedRecipe]
    private let randomRecipesCount: Int = 100
    
    init(with service: FeedServiceProtocol) {
        self.service = service
        recipes = []
    }
}

// MARK: - FeedPresenterProtocol
extension FeedPresenter: FeedPresenterProtocol {
    func viewWillAppear() {
        view?.configNavigation()
        view?.reloadCollection()
    }
    
    func viewWillDisappear() {
    }
    
    func viewDidLoad() {
        view?.setupView()
        loadRandomRecipes()
    }
    
    func recipe(at index: IndexPath) -> FeedRecipe? {
        if index.row < 0 || index.row >= recipes.count {
            return nil
        }
        return recipes[index.row]
    }
    
    func recipesCount() -> Int {
        return recipes.count
    }
    
    func willDisplayCell(at index: IndexPath) {
        if index.row < 0 || index.row >= recipes.count {
            return 
        }
        if recipes[index.row].imageData == nil {
            loadImage(at: index)
        }
    }
    
    func didEndDisplayCell(at index: IndexPath) {
        if index.row < 0 || index.row >= recipes.count {
            return
        }
        self.cancelLoad(at: index)
    }
}

// MARK: - Working with service layer methods
extension FeedPresenter {
    private func recipesDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollection()
        }
    }
    
    private func imageDidLoad(at index: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [index])
        }
    }
    
    private func loadRandomRecipes() {
        service.loadRandomRecipes(randomRecipesCount, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.recipes.map { FeedRecipe(with: $0) }
                self?.recipesDidLoad()
            case let .failure(error):
                print(error)
            }
        })
    }
    
    private func loadImage(at index: IndexPath) {
        guard let url = recipes[index.row].image else {
            return
        }
        
        service.loadImage(at: index, with: url, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.setImageData(at: index, result)
                self?.imageDidLoad(at: index)
            case let .failure(error):
                print(error)
            }
        })
    }
    
    private func cancelLoad(at index: IndexPath) {
        service.cancelRequest(at: index)
    }
    
    private func setImageData(at index: IndexPath, _ data: Data) {
        recipes[index.row].imageData = data
    }
}
