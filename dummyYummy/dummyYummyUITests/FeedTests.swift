//
//  dummyYummyUITests.swift
//  dummyYummyUITests
//
//  Created by badyi on 18.07.2021.
//

import XCTest

class FeedTests: XCTestCase {
    private var app: XCUIApplication!
    private var feedPage: FeedSearchPage!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["-hasBeenLaunchdBeforeFlag", "true"]
        app.launch()

        feedPage = FeedSearchPage(app: app)
    }

    func testScroll() {
        // Tenth cell id
        let cellID = AccessibilityIdentifiers.FeedViewControlller.cell + "-0-10"
        let findCell = feedPage.scrollDown(to: cellID, maxScrolls: 100)
        feedPage.tapCellTarget()

        XCTAssertNotNil(findCell)
        XCTAssert(app.collectionViews[AccessibilityIdentifiers.DetailViewController.collectionView].exists)
    }
}
