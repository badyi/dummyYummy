//
//  FeedSearchCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 26.07.2021.
//

import Foundation

protocol FeedSearchCoordinatorProtocol: Coordinator {

    /// Show feed search flow
    func showFeedSearch()

    /// Show detail flow
    /// - Parameter recipe: recipe for showing detail
    func showDetail(with recipe: Recipe)
}
