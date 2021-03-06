//
//  FeedProtocols.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import Foundation

protocol FeedViewProtocol: RecipesViewProtocol {

    /// Reload collection view
    func reloadCollectionView()

    /// Function for reloading collection view at specific indexes
    /// - Parameter indexPaths: indexes of cells to reload
    func reloadItems(at indexPaths: [IndexPath])

    /// Need this method to stop
    /// animtion in visible cells when new view controller is pushed
    func stopVisibleCellsAnimation()

    /// Reload visible cells on user screen
    func reloadVisibleCells()
}
