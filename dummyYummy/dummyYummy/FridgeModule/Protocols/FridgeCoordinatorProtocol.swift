//
//  FridgeCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol FridgeCoordinatorProtocol: Coordinator {
    func showFridge()
    func showDetail(with recipe: Recipe)
    func showErrorAlert(with text: String)
}
