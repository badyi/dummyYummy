//
//  FavoritesProtocols.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

protocol FavoritesViewProtocol: RecipesViewProtocol {
    func setupView()
    func reloadCollection()
}

protocol FavoritesPresenterProtocol {
    init(with view: FavoritesViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol)

    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func recipeTitle(at index: IndexPath) -> String?
    func willDisplayCell(at indexPath: IndexPath)
    func didEndDisplayingCell(at indexPath: IndexPath)
    func didSelectCell(at indexPath: IndexPath)
}

// protocol FavoritesNavigationDelegate {
//    
// }
