//
//  FeedProtocols.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import Foundation

protocol FeedViewProtocol: AnyObject {
    
    /// Setup and config all subviews on view controleller
    func setupView()
    
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

protocol FeedPresenterProtocol: AnyObject {
    init(with view: FeedViewProtocol, _ networkService: FeedServiceProtocol, _ dataBaseService: DataBaseServiceProtocol, _ fileSystemService: FileSystemServiceProtocol)
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func willDisplayCell(at indexPath: IndexPath)
    func didEndDisplayingCell(at indexPath: IndexPath)
    func didSelectCell(at indexPath: IndexPath)
    
    /// Returns title at specifix index
    /// - Parameter index: irecipe index whose title should be returned
    func recipeTitle(at index: IndexPath) -> String?
}

protocol FeedServiceProtocol {
    
    /// Load random recipes from api
    /// - Parameters:
    ///   - count: count of recipes
    ///   - completion: number of recipes to download
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<FeedRecipeResponse>) -> ())
    
    /// Load image
    /// - Parameters:
    ///   - indexPath: the index of the cell that asks to download the image
    ///   - url: url of image
    ///   - completion: result of downloading
    func loadImage(at indexPath: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ())
    
    /// Cancel request at index
    /// - Parameter index: the index of the cell that asked to download the image
    func cancelRequest(at indexPath: IndexPath)
}

protocol FeedNavigationDelegate {
    
    /// Handle tap on cell
    /// - Parameter recipe: the recipe that was touched
    func feedDidTapCell(with recipe: Recipe)
}
