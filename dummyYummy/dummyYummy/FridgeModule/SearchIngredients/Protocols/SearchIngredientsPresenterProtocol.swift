//
//  SearchIngredientsPresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol SearchIngredientsPresenterProtocol {
    init(with view: SearchIngredientsViewProtocol,
         _ networkService: SearchIngredientsNetworkProtocol)

    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func reloadTable()
    func willDisplayCell(at indexPath: IndexPath)
    func didEndDisplayingCell(at indexPath: IndexPath)
    func didSelectCell(at indexPath: IndexPath)
    func title(at indexPath: IndexPath) -> String
}
