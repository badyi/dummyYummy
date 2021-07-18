//
//  FeedPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 18.07.2021.
//

import Foundation

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
