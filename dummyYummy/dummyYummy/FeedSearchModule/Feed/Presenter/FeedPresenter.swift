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
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol
    
    var navigationDelegate: RecipesNavigationDelegate?//FeedNavigationDelegate?
    
    var recipes: [Recipe]
    private let randomRecipesCount: Int = 100
    
    init(with view: FeedViewProtocol, _ networkService: FeedServiceProtocol, _ dataBaseService: DataBaseServiceProtocol, _ fileSystemService: FileSystemServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.dataBaseService = dataBaseService
        self.fileSystemService = fileSystemService
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
    
    func recipeTitle(at index: IndexPath) -> String? {
        if index.row < 0 || index.row >= recipes.count {
            return nil
        }
        return recipes[index.row].title
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
    
    func didSelectCell(at indexPath: IndexPath) {
        guard let recipe = recipe(at: indexPath) else {
            return
        }
        navigationDelegate?.didTapCell(with: recipe)
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
                self?.recipes = result.recipes.map { Recipe(with: $0) }
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
    
    func recipe(at index: IndexPath) -> Recipe? {
        if index.row < 0 || index.row >= recipes.count {
            return nil
        }
        return recipes[index.row]
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
            recipe.isFavorite = checkFavoriteStatus(at: indexPath)
            
            cell.configView(with: recipe)
            cell.stopAnimation()
            cell.favoriteButtonTapHandle = { [weak self] in
                self?.handleFavoriteTap(at: indexPath)
                self?.view?.reloadItems(at: [indexPath])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            willDisplayCell(at: $0)
        }
    }
}

private extension FeedPresenter {
    func handleFavoriteTap(at indexPath: IndexPath) {
        guard let recipe = recipe(at: indexPath) else {
            return
        }
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
        
        if dataBaseService.recipes(with: predicate).count > 0 {
            dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])
            if recipe.imageData != nil {
                fileSystemService.delete(forKey: "\(recipe.id)")
            }
            return
        }
        
        if let data = recipe.imageData {
            fileSystemService.store(imageData: data, forKey: "\(recipe.id)")
        }
        dataBaseService.update(recipes: [RecipeDTO(with: recipe)])
    }
    
    func checkFavoriteStatus(at indexPath: IndexPath) -> Bool {
        guard let recipe = recipe(at: indexPath) else {
            return false
        }
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
        if dataBaseService.recipes(with: predicate).count > 0 {
            return true
        }
        return false
    }
}
