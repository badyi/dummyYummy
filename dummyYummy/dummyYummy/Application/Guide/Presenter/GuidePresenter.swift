//
//  GuidePresenter.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import Foundation

final class GuidePresenter: GuidePresenterProtocol {
    var navigationDelegate: GuideNavigationDelegate?

    func finished() {
        navigationDelegate?.finishGuide()
    }

    func start() {
        view?.update(with: pages)
    }

    weak var view: GuidePageViewProtocol?
    var pages: [GuideViewController]

    init(with view: GuidePageViewProtocol, _ pages: [GuideViewController]) {
        self.pages = pages
        self.view = view
    }
}
