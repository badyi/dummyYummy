//
//  FridgePresenter.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import Foundation

final class FridgePresenter {
    weak var view: FridgeViewProtocol?
    private var networkService: FridgeNetworkServiceProtocol

    init(with view: FridgeViewProtocol, _ networkService: FridgeNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
}

extension FridgePresenter: FridgePresenterProtocol {
    func viewDidLoad() {
        view?.setupView()
        view?.configNavigationBar()
    }

    func viewWillAppear() {
        view?.configNavigationBar()
    }
}

private extension FridgePresenter {

}
