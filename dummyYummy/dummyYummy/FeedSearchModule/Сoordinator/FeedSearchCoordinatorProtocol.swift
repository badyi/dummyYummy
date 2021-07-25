//
//  FeedSearchCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 26.07.2021.
//

import Foundation

protocol FeedSearchCoordinatorProtocol: Coordinator {
    func showFeedSearch()
    func showDetail(with recipe: Recipe)
}
