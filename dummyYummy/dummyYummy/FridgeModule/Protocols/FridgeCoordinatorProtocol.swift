//
//  FridgeCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

protocol FridgeCoordinatorProtocol: Coordinator {

    /// Show fridge flow
    func showFridge()

    /// show detail flow
    /// - Parameter recipe: recipe for detail
    func showDetail(with recipe: Recipe)

    /// Show error with alert
    /// - Parameter text: text for alert message
    func showErrorAlert(with text: String)
}
