//
//  FeedViewSpy.swift
//  dummyYummyTests
//
//  Created by badyi on 28.07.2021.
//

import Foundation

final class FeedViewSpy: FeedViewProtocol {

    var reloadCollectionViewCalled: Bool = false {
        didSet {
            reloadCollectionViewCallDidChange?()
        }
    }
    var reloadCollectionViewCallDidChange: (() -> Void)?

    var reloadIndexs: [IndexPath] = []
    var reloadItemsCalled: Bool = false {
        didSet {
            reloadItemsCalledDidChange?()
        }
    }
    var reloadItemsCalledDidChange: (() -> Void)?

    var presenter: FeedPresenterProtocol?

    func reloadCollectionView() {
        reloadCollectionViewCalled = true
    }

    func reloadItems(at indexPaths: [IndexPath]) {
        reloadItemsCalled = true
        reloadIndexs = indexPaths
    }

    func stopVisibleCellsAnimation() {}

    func reloadVisibleCells() {}
}
