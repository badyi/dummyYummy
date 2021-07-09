//
//  FeedPresenter.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedPresenter: NSObject {
    
    weak var view: FeedViewProtocol?
    private var networkService: FeedServiceProtocol
    
    var navigationDelegate: FeedNavigationDelegate?
    
    var recipes: [FeedRecipe]
    private let randomRecipesCount: Int = 10
    
    
    init(with view: FeedViewProtocol, _ service: FeedServiceProtocol) {
        self.view = view
        self.networkService = service
        recipes = []
    }
}

// MARK: - FeedPresenterProtocol
extension FeedPresenter: FeedPresenterProtocol {
    func viewWillAppear() {
        view?.configNavigation()
        view?.reloadVisibleCells()
    }
    
    func viewWillDisappear() {
        view?.stopVisibleCellsAnimation()
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
    
    func willDisplayCell(at index: IndexPath) {
        if index.row < 0 || index.row >= recipes.count {
            return 
        }
        loadImageIfNeeded(at: index)
    }
    
    func didEndDisplayingCell(at index: IndexPath) {
        if index.row < 0 || index.row >= recipes.count {
            return
        }
        self.cancelLoad(at: index)
    }
    
    func didSelectCellAt(_ indexPath: IndexPath) {
        guard let recipe = recipe(at: indexPath) else {
            return
        }
        navigationDelegate?.feedDidTapCell(with: recipe)
    }
}

// MARK: - Working with service layer methods
private extension FeedPresenter {
    func recipesDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadCollection()
        }
    }
    
    func imageDidLoad(at index: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadItems(at: [index])
        }
    }
    
    func loadRandomRecipes() {
        networkService.loadRandomRecipes(randomRecipesCount, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.recipes = result.recipes.map { FeedRecipe(with: $0) }
                self?.recipesDidLoad()
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    func loadImageIfNeeded(at index: IndexPath) {
        if recipes[index.row].imageData != nil {
            return
        }
        guard let url = recipes[index.row].imageURL else {
            return
        }
        networkService.loadImage(at: index, with: url, completion: { [weak self] result in
            switch result {
            case let .success(result):
                self?.setImageData(at: index, result)
                self?.imageDidLoad(at: index)
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    func cancelLoad(at index: IndexPath) {
        networkService.cancelRequest(at: index)
    }
    
    func setImageData(at index: IndexPath, _ data: Data) {
        recipes[index.row].imageData = data
    }
}

// MARK: - UICollectionViewDataSource
extension FeedPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// in case the recipes haven't loaded yet
        /// we put a few fake cells with animations
        let count = recipes.count
        return count == 0 ? FeedConstants.VC.Layout.emptyCellsCount : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.id, for: indexPath) as! FeedCell
        
        cell.startAnimation()
        if let recipe = recipe(at: indexPath) {
            cell.configView(with: recipe)
            cell.stopAnimation()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            willDisplayCell(at: $0)
        }
    }
}
