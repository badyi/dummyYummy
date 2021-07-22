//
//  FavoritesPresenter.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

final class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    private var dataBaseService: DataBaseServiceProtocol
    private var fileSystemService: FileSystemServiceProtocol

    weak var navigationDelegate: RecipesNavigationDelegate?

    private var searchText: String = ""

    private var _recipes: [Recipe]

    var recipes: [Recipe] {
        get {
            if searchText == "" {
                return _recipes
            }
            return _recipes.filter { $0.title.contains(searchText) }
        }
        set {
            _recipes = newValue
        }
    }

    init(with view: FavoritesViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol) {

        self.view = view
        self.dataBaseService = dataBaseService
        self.fileSystemService = fileSystemService
        _recipes = []
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func retriveRecipes() {
        recipes = dataBaseService.allRecipes().map { Recipe(with: $0) }
        view?.reloadCollectionView()
    }

    func retriveImageIfNeeded(at index: Int) {
        if let image = fileSystemService.retrieveImageData(forKey: "\(recipes[index].id)") {
            recipes[index].imageData = image
        }
    }

    func recipesCount() -> Int {
        return recipes.count
    }

    func recipe(at index: Int) -> Recipe? {
        if index < 0 || index >= recipes.count {
            return nil
        }
        retriveImageIfNeeded(at: index)

        return recipes[index]
    }

    func recipeTitle(at index: Int) -> String? {
        recipes[index].title
    }

    func didSelectRecipe(at index: Int) {
        navigationDelegate?.didTapRecipe(recipes[index])
    }

    func handleFavoriteTap(at index: Int) {
        let recipe = recipes[index]
        dataBaseService.delete(recipes: [RecipeDTO(with: recipe)])
        if recipe.imageData != nil {
            fileSystemService.delete(forKey: "\(recipe.id)", completionStatus: nil)
        }
        recipes = dataBaseService.allRecipes().map { Recipe(with: $0) }
        view?.reloadCollectionView()
    }

    func updateSearchText(_ text: String) {
        searchText = text
        view?.reloadCollectionView()
    }
}
