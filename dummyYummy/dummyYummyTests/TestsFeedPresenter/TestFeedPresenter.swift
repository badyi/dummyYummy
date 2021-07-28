//
//  TestFeedPresenter.swift
//  dummyYummyTests
//
//  Created by badyi on 27.07.2021.
//

import XCTest

class TestFeedPresenter: XCTestCase {
    var sut: FeedPresenterProtocol!
    var spy: FeedViewSpy!

    override func setUp() {
        super.setUp()
        spy = FeedViewSpy()
        sut = FeedPresenter(with: spy,
                            StubFeedNetworkService(),
                            FakeDBService(coreDataStack: MockCoreDataStack.shared),
                            FakeFileSystemService())
        spy.presenter = sut
    }

    func testPresenterShouldCallReloadCollectionViewWhenLoadedRecipes() {
        sut.loadRandomRecipes()
        let expectation = expectation(description: "expect for reload collection")
        spy.reloadCollectionViewCallDidChange = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(self.spy.reloadCollectionViewCalled, "Should call reload collection view")
    }

    func testPresenterShouldCallReloadItemsWhenRecipePrepared() {
        sut.loadRandomRecipes()
        sut.prepareRecipe(at: 0)

        let expectation = expectation(description: "Expect for load")
        spy.reloadItemsCalledDidChange = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)

        XCTAssertTrue(self.spy.reloadItemsCalled, "Should call reload collection view")
        XCTAssertEqual(spy.reloadIndexs, [IndexPath(row: 0, section: 0)])
    }

    func testPresentorGetRecipeTitleWhenRecipeLoaded() {
        sut.loadRandomRecipes()

        let title = sut.recipeTitle(at: 0)

        XCTAssertEqual(title, "testTitle", "Should be equal")
    }

    func testPresentorThatTappedRecipeWasStoredToDBAndThenDeleted() {
        sut.loadRandomRecipes()
        sut.handleFavoriteTap(at: 0)
        var isFavorite = false

        isFavorite = self.sut.isFavorite(at: 0)

        XCTAssertTrue(isFavorite, "Should be favorite")
    }
}
