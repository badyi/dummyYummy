//
//  FavoritesPresenter.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

final class FavoritesPresenter: NSObject {
    weak var view: FavoritesViewProtocol?
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol
    
    var navigationDelegate: RecipesNavigationDelegate?
    
    private var recipes: [Recipe]
  
    init(with view: FavoritesViewProtocol, _ dataBaseService: DataBaseServiceProtocol, _ fileSystemService: FileSystemServiceProtocol) {
        self.view = view
        self.dataBaseService = dataBaseService
        self.fileSystemService = fileSystemService
        recipes = []
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func recipeTitle(at index: IndexPath) -> String? {
        recipes[index.row].title
    }
    
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewWillAppear() {
        view?.configNavigation()
        recipes = dataBaseService.allRecipes().map { Recipe(with: $0) }
        view?.reloadCollection()
    }
    
    func viewWillDisappear() {
        
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        
    }
    
    func didEndDisplayingCell(at indexPath: IndexPath) {
        
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        navigationDelegate?.didTapCell(with: recipes[indexPath.row])
    }
}

extension FavoritesPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.id, for: indexPath) as! FavoriteCell
        let filemanager = FileSystemService()
        if let image = filemanager.retrieveImageData(forKey: "\(recipes[indexPath.row].id)") {
            recipes[indexPath.row].imageData = image
        }
        cell.configView(with: recipes[indexPath.row])
        
        cell.favoriteButtonTapHandle = { [weak self] in
            self?.handleFavoriteTap(at: indexPath)
            collectionView.reloadData()
        }
        return cell
    }
}

private extension FavoritesPresenter {
    func handleFavoriteTap(at indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])
        if recipe.imageData != nil {
            fileSystemService.delete(forKey: "\(recipe.id)")
        }
        recipes = dataBaseService.allRecipes().map { Recipe(with: $0) }
    }
}
