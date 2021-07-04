//
//  DetailProtocols.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
}

protocol DetailPresenterProtocol {
    init(with view: DetailViewProtocol)
    func setupView()
}

protocol DetailNetworkServiceProtocol {
    
}
