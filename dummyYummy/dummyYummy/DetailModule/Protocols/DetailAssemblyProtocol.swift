//
//  DetailAssemblyProtocol.swift
//  dummyYummy
//
//  Created by badyi on 29.07.2021.
//

import Foundation

protocol DetailAssemblyProtocol {

    /// Create detail module
    /// - Parameters:
    ///   - recipe: recipe for detail
    ///   - navigationDelegate: navigation delegate
    func createDetailModule(_ recipe: Recipe, _ navigationDelegate: DetailNavigationDelegate) -> DetailViewController
}
