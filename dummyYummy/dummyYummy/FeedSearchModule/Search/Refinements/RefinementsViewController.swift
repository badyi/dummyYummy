//
//  RefinementsViewController.swift
//  dummyYummy
//
//  Created by badyi on 23.06.2021.
//

import UIKit

final class RefinementsViewController: UIViewController {
    
    let refinementsSections: [RefinementsSection : Int] = [.time : 1, .cuisine : 2, .diet : 1, .intolearns : 1]
    
    let refinementsOrder: [RefinementsSection] = [.time, .cuisine, .diet, .intolearns]
    
    var refinements: SearchRefinements
    
    init(with refinements: SearchRefinements) {
        self.refinements = refinements
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChilds()
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
    func setupChilds() {
        let childViewController = RefinementsTableViewController()
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(childViewController.view)
        addChild(childViewController)
        
        childViewController.didMove(toParent: self)
        childViewController.tableView.dataSource = self


        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            childViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = FeedVCConstants.Design.navBarBackgroundColor
    }
}

extension RefinementsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return refinementsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refinementsSections[refinementsOrder[section]] ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RefinementCell.id, for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
}
