//
//  SearchIngredientsViewController.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

final class SearchIngredientsViewController: UIViewController {
    var willAppear: (() -> Void)?
    var willFinish: (([String]?) -> Void)?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = FridgeConstants.ViewController.Design.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IngredinentsCell.self, forCellReuseIdentifier: IngredinentsCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultID)
        return tableView
    }()

    var presenter: SearchIngredientsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear?()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willFinish?(presenter?.chosenIngredinets)
    }

    func setupSearchController(_ searchController: UISearchController) {
        searchController.searchResultsUpdater = presenter as? UISearchResultsUpdating
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDataSource
extension SearchIngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.ingredientsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredinentsCell.id,
                                                       for: indexPath) as? IngredinentsCell else {
            return tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultID, for: indexPath)
        }

        guard let presenter = presenter else {
            return cell
        }

        let ingredient = presenter.title(at: indexPath.row)
        cell.config(with: ingredient, presenter.isChosen(ingredient))

        cell.choseButtonTapDelegate = {
            presenter.handleChooseTap(at: ingredient)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchIngredientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = presenter?.title(at: indexPath.row) ?? ""
        let height = IngredinentsCell.heightForCell(with: title, width: tableView.bounds.width)
        let minimalHeight = SearchIngredientsConstants.ViewController.Layout.mimimalCellHeight

        return height < minimalHeight ? minimalHeight : height
    }
}

// MARK: - SearchIngredientsViewProtocol
extension SearchIngredientsViewController: SearchIngredientsViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension SearchIngredientsViewController {
    private func setupView() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        setupTableView()
    }

    private func configNavigation() {

    }

    private func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UISearchResultsUpdating
extension SearchIngredientsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter?.loadSearch(text)
    }
}

// extension SearchIngredientsViewController: UISearchBarDelegate {
//
// }
