//
//  DetailPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol DetailPresenterProtocol {
    init(with view: DetailViewProtocol,
         _ dataBaseService: DataBaseServiceProtocol,
         _ fileSystemService: FileSystemServiceProtocol,
         _ networkService: DetailNetworkServiceProtocol,
         _ recipe: Recipe)

    func viewDidLoad()
    func viewWillAppear()
    func headerTitle() -> String
    func ingredientTitle(at indexPath: IndexPath) -> String
    func instructionTitle(at indexPath: IndexPath) -> String
    func characteristic(at indexPath: IndexPath) -> String
    func getCharacteristics() -> ExpandableCharacteristics
    func headerTapped(_ section: Int)
    func getRecipe() -> Recipe
    func handleFavoriteTap(at indexPath: IndexPath)
    func handleShareTap(at indexPath: IndexPath)
    func segmentDidChange()
}
