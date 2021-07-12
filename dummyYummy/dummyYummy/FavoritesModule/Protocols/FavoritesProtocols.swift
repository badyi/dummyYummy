//
//  FavoritesProtocols.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
}

protocol FavoritesPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayingCell(at index: IndexPath)
    func recipe(at index: IndexPath) -> Recipe?
    func didSelectCellAt(_ indexPath: IndexPath)
}
