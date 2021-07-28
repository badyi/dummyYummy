//
//  DetailCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 27.07.2021.
//

import Foundation

protocol DetailCoordinatorProtocol: Coordinator {
    func showDetail()
    func showErrorAlert(with text: String)
    func showActivity(with url: String)
}
