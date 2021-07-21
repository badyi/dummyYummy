//
//  SearchIngredientsViewController.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class SearchIngredientsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = FridgeConstants.ViewController.Design.backgroundColor
        tableView.delegate = self
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.register(IngredinentsCell.self, forCellReuseIdentifier: IngredinentsCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        return tableView
    }()

    var presenter: SearchIngredientsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func setupSearchController(_ searchController: UISearchController) {
        searchController.searchResultsUpdater = presenter as? UISearchResultsUpdating
        navigationItem.searchController = searchController
    }
}

extension SearchIngredientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.didEndDisplayingCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = presenter?.title(at: indexPath) ?? ""
        let height = IngredinentsCell.heightForCell(with: title, width: tableView.bounds.width)
        let minimalHeight = SearchIngredientsConstants.ViewController.Layout.mimimalCellHeight

        return height < minimalHeight ? minimalHeight : height
    }
}

extension SearchIngredientsViewController: SearchIngredientsViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }

    func setupView() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        setupTableView()
    }

    func configNavigation() {

    }
}

private extension SearchIngredientsViewController {
    func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
