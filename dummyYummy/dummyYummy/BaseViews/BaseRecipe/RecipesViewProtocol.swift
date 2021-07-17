//
//  RecipeViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 17.07.2021.
//

import UIKit

protocol RecipesViewProtocol: AnyObject {
    
    /// Setup collection view
    func setupCollectionView()
    
    /// Config view of navigation bar
    func configNavigation()
    
    /// Reload collection view
    func reloadCollection()
    
    /// Function for reloading collection view at specific indexes
    /// - Parameter indexPaths: indexes of cells to reload
    func reloadItems(at indexPaths: [IndexPath])
    
    /// Need this method to stop
    /// animtion in visible cells when new view controller is pushed
    func stopVisibleCellsAnimation()
    
    /// Reload visible cells on user screen
    func reloadVisibleCells()
}

protocol RecipesNavigationDelegate {
    func didTapCell(with recipe: Recipe)
}
