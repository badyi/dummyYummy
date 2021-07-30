//
//  TestFeedPresenter.swift
//  dummyYummyTests
//
//  Created by badyi on 27.07.2021.
//

import XCTest

final class NavigationSpy: RecipesViewNavigationDelegate {
    var didTapRecipeCalled = false
    var acitivityCalled = false

    func didTapRecipe(_ recipe: Recipe) {
        didTapRecipeCalled = true
    }

    func error(with description: String) {}

    func activity(with url: String) {
        acitivityCalled = true
    }
}

final class TestFeedPresenter: XCTestCase {
    var sut: FeedPresenterProtocol!
    var viewSpy: FeedViewSpy!
    var navigationSpy: NavigationSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = NavigationSpy()
        viewSpy = FeedViewSpy()
        let presenter = FeedPresenter(with: viewSpy,
                            StubFeedNetworkService(),
                            FakeDBService(coreDataStack: MockCoreDataStack.shared),
                            FakeFileSystemService())
        presenter.navigationDelegate = navigationSpy
        sut = presenter
        viewSpy.presenter = presenter
    }

    func testPresenterShouldCallReloadCollectionViewWhenLoadedRecipes() {
        sut.loadRandomRecipes()
        let expectation = expectation(description: "expect for reload collection")

        viewSpy.reloadCollectionViewCallDidChange = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(self.viewSpy.reloadCollectionViewCalled, "Should call reload collection view")
    }

    func testPresenterShouldCallReloadItemsWhenRecipePrepared() {
        sut.loadRandomRecipes()
        sut.prepareRecipe(at: 0)

        let expectation = expectation(description: "Expect for load")
        viewSpy.reloadItemsCalledDidChange = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)

        XCTAssertTrue(self.viewSpy.reloadItemsCalled, "Should call reload collection view")
        XCTAssertEqual(viewSpy.reloadIndexs, [IndexPath(row: 0, section: 0)])
    }

    func testPresenterGetRecipeTitleWhenRecipeLoaded() {
        sut.loadRandomRecipes()

        let title = sut.recipeTitle(at: 0)

        XCTAssertEqual(title, "testTitle", "Should be equal")
    }

    func testPresenterWhenRecipeFavoriteButtonWasTappedAndRecipeWasSavedToDBAndThenDeleted() {
        sut.loadRandomRecipes()
        sut.handleFavoriteTap(at: 0)
        var isFavorite = false

        isFavorite = self.sut.isFavorite(at: 0)

        XCTAssertTrue(isFavorite, "Should be favorite")

        sut.handleFavoriteTap(at: 0)

        isFavorite = self.sut.isFavorite(at: 0)

        XCTAssertFalse(isFavorite, "Shouldn't be favorite")
    }

    func testPresentorWhenRecipeWasTapped() {
        sut.loadRandomRecipes()
        sut.didSelectRecipe(at: 0)

        XCTAssertTrue(navigationSpy.didTapRecipeCalled, "Should call did tap recipe method")
    }

    func testPresentorWhenRecipeShareButtonWasTapped() {
        sut.loadRandomRecipes()
        sut.handleShareTap(at: 0)

        XCTAssertTrue(navigationSpy.acitivityCalled, "Should call did tap recipe method")
    }
}
