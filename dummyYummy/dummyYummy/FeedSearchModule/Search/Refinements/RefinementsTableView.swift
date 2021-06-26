//
//  RefinementsTableView.swift
//  dummyYummy
//
//  Created by badyi on 26.06.2021.
//

import UIKit

final class RefinementsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.register(RefinementCell.self, forCellReuseIdentifier: RefinementCell.id)
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        view.backgroundColor = .orange
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
