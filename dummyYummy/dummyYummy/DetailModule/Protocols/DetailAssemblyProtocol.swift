//
//  DetailAssemblyProtocol.swift
//  dummyYummy
//
//  Created by badyi on 29.07.2021.
//

import Foundation

protocol DetailAssemblyProtocol {
    func createDetailModule(_ recipe: Recipe, _ navigationDelegate: DetailNavigationDelegate) -> DetailViewController
}
