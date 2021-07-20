//
//  FridgeViewViewController.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import UIKit

final class FridgeViewController: UIViewController {
    var presenter: FridgePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension FridgeViewController: FridgeViewProtocol {
    func setupView() {

    }
}
