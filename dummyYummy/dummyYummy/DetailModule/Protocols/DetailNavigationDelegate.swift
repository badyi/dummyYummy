//
//  DetailNavigationDelegate.swift
//  dummyYummy
//
//  Created by badyi on 26.07.2021.
//

import Foundation

protocol DetailNavigationDelegate: AnyObject {
    func error(with description: String)
    func share(with url: String)
}
