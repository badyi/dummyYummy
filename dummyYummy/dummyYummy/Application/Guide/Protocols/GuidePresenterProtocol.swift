//
//  GuidePresenterProtocol.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import Foundation

protocol GuidePresenterProtocol {
    var pages: [GuideViewController] { get }

    func start()
    func finished()
}
