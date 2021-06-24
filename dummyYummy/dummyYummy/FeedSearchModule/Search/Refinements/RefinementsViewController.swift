//
//  RefinementsViewController.swift
//  dummyYummy
//
//  Created by badyi on 23.06.2021.
//

import UIKit

final class RefinementsViewController: UIViewController {
    
    var refinementsView: RefinementsViewProtocol
    
    let refinementsSections: [RefinementsSection : Int] = [.time : 1, .cuisine : 2, .diet : 1, .intolearns : 1]
    
    let refinementsOrder: [RefinementsSection] = [.time, .cuisine, .diet, .intolearns]
    
    var refinements: SearchRefinements
    
    init(with view: RefinementsViewProtocol, _ refinements: SearchRefinements) {
        self.refinements = refinements
        refinementsView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = (refinementsView as! UIView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refinementsView.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension RefinementsViewController {    
    private func configNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = FeedViewControllerColors.navBarBackgroundColor
        //tabBarController?.tabBar.isHidden = true
    }
}

extension RefinementsViewController: RefinementsControllerProtocol {
    func sectionsCount() -> Int {
        refinementsSections.count
    }
    
    func numberOfRowsIn(_ section: Int) -> Int {
        refinementsSections[refinementsOrder[section]] ?? 0
    }
}
