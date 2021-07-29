//
//  DetailNavigationDelegate.swift
//  dummyYummy
//
//  Created by badyi on 26.07.2021.
//

import Foundation

protocol DetailNavigationDelegate: AnyObject {

    /// Show error
    /// - Parameter description: description for alert message
    func error(with description: String)

    /// Show activity for url
    /// - Parameter url: url to share
    func share(with url: String)
}
