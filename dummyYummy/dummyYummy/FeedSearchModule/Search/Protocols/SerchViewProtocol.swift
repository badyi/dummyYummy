//
//  SerchViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func setupView()
    func reloadCollection()
    func reloadItems(at indexPaths: [IndexPath])
    func configNavigation()
}
