//
//  FridgeViewViewController.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import UIKit

final class FridgeViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = FridgeConstants.ViewController.Design.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = FridgeConstants.ViewController.Layout.tableViewInsets
        tableView.register(IngredinentsCell.self, forCellReuseIdentifier: IngredinentsCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultID)
        return tableView
    }()

    private lazy var showSearchResultsButton: UIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(Colors.wisteria)
            .cornerRadius(FridgeConstants.ViewController.Layout.buttonCornerRaius)
            .title("Search recipes")
            .build()
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    var presenter: FridgePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }

    func setupSearchController(_ searchController: UISearchController) {
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        navigationItem.searchController = searchController
        let textColor = FridgeConstants.ViewController.Design.searchTextColor
        navigationItem.searchController?.searchBar.searchTextField.textColor = textColor
    }
}

// MARK: - FrdigeViewProtocol
extension FridgeViewController: FridgeViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension FridgeViewController {
    @objc
    private func buttonTapped() {
        presenter?.didTapSearchButton()
    }

    private func setupView() {
        title = "What's in the fridge?"
        view.backgroundColor = FridgeConstants.ViewController.Design.backgroundColor
        navigationItem.searchController?.searchBar.placeholder = "Search ingredinets"
        view.addSubview(tableView)
        view.addSubview(showSearchResultsButton)

        setupTableView()
        setupSearchButton()
    }

    private func configNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:
                                FridgeConstants.ViewController.Design.navigationTextColor]

        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        let backgroundColor = FridgeConstants.ViewController.Design.navBarBackgroundColor
        navigationController?.navigationBar.backgroundColor = backgroundColor

        navigationController?.navigationBar.barTintColor = FridgeConstants.ViewController.Design.navBarBarTintColor
        navigationController?.navigationBar.tintColor = FridgeConstants.ViewController.Design.navBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true

        // need nav bar back view image to avoid some ios bag with search result controller frame on search bar tap
        navigationController?.navigationBar.setBackgroundImage(FridgeConstants.ViewController.Image.navBarBackground,
                                                               for: .default)
        navigationController?.navigationBar.shadowImage = FridgeConstants.ViewController.Image.navBarShadowImage
        navigationController?.view.backgroundColor = FridgeConstants.ViewController.Design.navBarBarTintColor

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupSearchButton() {
        let buttonHeight = FridgeConstants.ViewController.Layout.searchButtonHeight
        NSLayoutConstraint.activate([
            showSearchResultsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                             constant: 50),
            showSearchResultsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                              constant: -50),
            showSearchResultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                            constant: -10),
            showSearchResultsButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}

// MARK: - UITableViewDataSource
extension FridgeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.ingredientsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = IngredinentsCell.id
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id,
                                                       for: indexPath) as? IngredinentsCell else {
            return tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultID, for: indexPath)
        }

        if let title = presenter?.title(at: indexPath.row) {
            cell.config(with: title)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FridgeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = presenter?.title(at: indexPath.row) ?? ""
        let height = IngredinentsCell.heightForCell(with: title, width: tableView.bounds.width)
        let minimalHeight = SearchIngredientsConstants.ViewController.Layout.mimimalCellHeight

        return height < minimalHeight ? minimalHeight : height
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            presenter?.delete(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
