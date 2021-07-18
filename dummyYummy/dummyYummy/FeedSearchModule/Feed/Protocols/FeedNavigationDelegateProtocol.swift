//
//  FeedNavigationDelegateProtocol.swift
//  dummyYummy
//
//  Created by badyi on 18.07.2021.
//

import Foundation

protocol FeedNavigationDelegate {
    
    /// Handle tap on cell
    /// - Parameter recipe: the recipe that was touched
    func feedDidTapCell(with recipe: Recipe)
}
