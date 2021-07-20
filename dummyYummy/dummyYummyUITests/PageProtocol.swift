//
//  PageProtocol.swift
//  dummyYummyUITests
//
//  Created by badyi on 19.07.2021.
//

import Foundation
import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}
