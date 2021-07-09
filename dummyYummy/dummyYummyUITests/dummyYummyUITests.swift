//
//  dummyYummyUITests.swift
//  dummyYummyUITests
//
//  Created by badyi on 07.07.2021.
//

import XCTest

class dummyYummyUITests: XCTestCase {
    var app: XCUIApplication!
    
//    override func setUp() {
//        continueAfterFailure = false
//        app = XCUIApplication()
//        app.launchArguments = "testing"
//        app.launch()
//    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testThatWeCanOpenDetailVC() throws {
        // Arrange
        let cellsQuery = app.collectionViews.cells
        let firstCell = cellsQuery.element(boundBy: 0)
        
        //Assert
        XCTAssert(firstCell.buttons["Share"].exists)
        XCTAssert(firstCell.buttons["suit.heart"].exists)
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
