//
//  DetailViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setupView()
    func configNavigationBar()
    func reloadSection(_ section: Int)
    func reloadCollection()
}
