//
//  DetailAssembly.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

protocol DetailAssemblyProtocol {
    func createDetailModule(_ recipe: Recipe, _ navigationDelegate: DetailNavigationDelegate) -> DetailViewController
}

final class DetailAssembly: DetailAssemblyProtocol {
    func createDetailModule(_ recipe: Recipe, _ navigationDelegate: DetailNavigationDelegate) -> DetailViewController {
        let detailViewController = DetailViewController()
        let networkService = DetailNetworkService()
        let dataBaseService = DataBaseService(coreDataStack: CoreDataStack.shared)
        let fileSystemService = FileSystemService()
        let presenter = DetailPresenter(with: detailViewController,
                                        dataBaseService,
                                        fileSystemService,
                                        networkService,
                                        recipe)
        presenter.navigationDelegate = navigationDelegate
        detailViewController.presenter = presenter
        return detailViewController
    }
}
