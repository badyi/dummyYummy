//
//  RefinementsProtocols.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import UIKit

protocol RefinementsViewProtocol {
    func setupView()
}

protocol RefinementsControllerProtocol: AnyObject {
    func sectionsCount() -> Int
    func numberOfRowsIn(_ section: Int) -> Int
}
