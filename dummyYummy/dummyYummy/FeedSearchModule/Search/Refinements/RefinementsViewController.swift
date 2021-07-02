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
        return tv
    }()
    
    var willFinish: ((SearchRefinements) -> ())?
    
    var presenter: RefinementsPresenterProtocol
    
    init(with presenter: RefinementsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.register(RefinementInputCell.self, forCellReuseIdentifier: RefinementInputCell.id)
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        view.backgroundColor = .orange
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func endEditing(_ flag: Bool) {
        view.endEditing(flag)
    }
}

extension RefinementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RefinementInputCell, cell.canBecomeFirstResponder {
           cell.becomeFirstResponder()
        }
        presenter.didSelectAt(indexPath)
    }
}

extension RefinementsViewController {
    @objc func backgroundTapped(_ sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func configNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = FeedVCConstants.Design.navBarBackgroundColor
    }
}

