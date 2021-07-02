//
//  RefinementsProtocols.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import UIKit

protocol RefinementsViewProtocol: AnyObject {
    var willFinish: ((SearchRefinements) -> ())? { get set }
    func setupView()
    func endEditing(_ flag: Bool)
    func configNavigation()
    
}

protocol RefinementsPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func willDisplayCell(at index: IndexPath)
    func didEndDisplayCell(at index: IndexPath)
    func didSelectAt(_ indexPath: IndexPath)
}
//protocol RefinementsViewControllerDelegate: AnyObject {
//    func sectionsCount() -> Int
//    func numberOfRowsIn(_ section: Int) -> Int
//}
