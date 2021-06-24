//
//  RefinementsView.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import UIKit

final class RefinementsView: UIView {
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemRed
        tv.register(RefinementCell.self, forCellReuseIdentifier: RefinementCell.id)
        return tv
    }()
    
    weak var controller: RefinementsControllerProtocol?
}

extension RefinementsView: RefinementsViewProtocol {
    func setupView() {
        backgroundColor = .systemBlue
        setupTableView()
    }
}

extension RefinementsView {
    private func setupTableView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension RefinementsView: UITableViewDelegate {}

extension RefinementsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        controller?.sectionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.numberOfRowsIn(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RefinementCell.id, for: indexPath)
        return cell
    }
}
