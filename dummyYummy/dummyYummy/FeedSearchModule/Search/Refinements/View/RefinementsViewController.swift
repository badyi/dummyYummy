//
//  RefinementsViewController.swift
//  dummyYummy
//
//  Created by badyi on 23.06.2021.
//

import UIKit

final class RefinementsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = presenter as? UITableViewDataSource
        tv.register(RefinementCell.self, forCellReuseIdentifier: RefinementCell.id)
        return tv
    }()
    
    var willFinish: ((SearchRefinements) -> ())?
    
    var presenter: RefinementsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension RefinementsViewController: RefinementsViewProtocol {
    func setupView() {
        view.backgroundColor = RefinementsConstants.VC.Design.backgroundColor

        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        view.addSubview(tableView)
        setupTableView()
    }
    
    func endEditing(_ flag: Bool) {
        view.endEditing(flag)
    }
    
    func configNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = FeedConstants.VC.Design.navBarBackgroundColor
    }
}

extension RefinementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return RefinementsConstants.VC.Layout.sectionFooterHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RefinementsConstants.VC.Layout.heightForRow
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RefinementCell, cell.canBecomeFirstResponder {
           cell.becomeFirstResponder()
        }
        presenter.didSelectAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footer = view as? UITableViewHeaderFooterView else {
            return
        }
        footer.contentView.backgroundColor = RefinementsConstants.VC.Design.backgroundColor
    }
}

private extension RefinementsViewController {
    
    @objc func backgroundTapped(_ sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func setupTableView() {
        /// put zero here so that the footer height method is called later
        tableView.sectionFooterHeight = 0
        
        tableView.contentInset = RefinementsConstants.VC.Layout.collectionInsets
        tableView.backgroundColor = RefinementsConstants.VC.Design.backgroundColor
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

