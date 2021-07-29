//
//  SerchViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol SearchViewProtocol: RecipesViewProtocol {
    func startActivityIndicator()
    func stopActivityIndicator()
}
