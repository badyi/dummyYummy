//
//  dummyYummySnapshotTests.swift
//  dummyYummySnapshotTests
//
//  Created by badyi on 29.07.2021.
//

import XCTest
import SnapshotTesting
@testable import dummyYummy

class FavoritesViewControllerTests: XCTestCase {
    func testFavoriteViewController() {
        let defaults = UserDefaults.standard
        let key = "isFirstLaunchFlag"
        defaults.setValue(false, forKey: key)

        let fridge = FridgeAssembly().createFridgeModule(self)
        assertSnapshot(matching: fridge, as: .image(on: .iPhone8))
    }
}

extension FavoritesViewControllerTests: FridgeNavigationDelegate {
    func didTapSearch(_ ingredients: [String]) {}

    func activity(with url: String) {}

    func error(with description: String) {}

    func didTapRecipe(_ recipe: Recipe) {}
}
