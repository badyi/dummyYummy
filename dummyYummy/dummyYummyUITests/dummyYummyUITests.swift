//
//  dummyYummyUITests.swift
//  dummyYummyUITests
//
//  Created by badyi on 18.07.2021.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}

class FeedSearchPage: Page {
    var app: XCUIApplication
    private let collectionView: XCUIElement
    private var cells: [XCUIElement]?
    private var cellTarget: XCUIElement?

    required init(app: XCUIApplication) {
        self.app = app
        cells = []
        cellTarget = nil
        collectionView = app.collectionViews["\(AccessibilityIdentifiers.FeedViewControlller.collectionView)"]
    }

    /// scroll to specific cell with accessibility id
    /// - Parameters:
    ///   - cellID: cell accessibility id
    ///   - maxScrolls: maximum scrolls to find cell
    /// - Returns: nil - cell was not found, xcuielement - cell was found
    func scrollDown(at cellID: String, maxScrolls: Int) -> XCUIElement? {
        
        let cell = collectionView.cells[cellID]
        var scrollCount = 0
        // Swipe down until it is visible
        while !cell.exists {
            app.swipeUp()
            scrollCount += 1;
            if scrollCount > maxScrolls {
                cellTarget = nil
            }
        }
        cellTarget = cell
        return cell
    }
  
    func tapCellTarget() {
        let cell = cellTarget
        cell?.tap()
    }
}



class FeedTests: XCTestCase {
    private var app: XCUIApplication!
    private var feedPage: FeedSearchPage!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        feedPage = FeedSearchPage(app: app)
    }

    func testCells() {
        //feedPage.scrollDownAndCollectAllCells()
    }
    
    func testScroll() {
        let cellID = AccessibilityIdentifiers.FeedViewControlller.cell + "-0-10"
        let findCell = feedPage.scrollDown(at: cellID, maxScrolls: 100)
        feedPage.tapCellTarget()
        
        XCTAssertNotNil(findCell)
        XCTAssert(app.collectionViews[AccessibilityIdentifiers.DetailViewController.collectionView].exists)
    }
}
