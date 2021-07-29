//
//  DetailViewProtocol.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import Foundation

protocol DetailViewProtocol: AnyObject {

    /// Reload specific section
    /// - Parameter section: number of section
    func reloadSection(_ section: Int)

    /// Reload all collection view
    func reloadCollection()
}
