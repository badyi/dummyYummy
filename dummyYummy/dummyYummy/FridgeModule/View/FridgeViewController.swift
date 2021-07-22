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
        tableView.backgroundColor = .blue
        return tableView
    }()

    private lazy var showSearchResultsButton: UIButton = {
        UIButtonBuilder()
            .backgroundColor(.red)
            .build()
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
    }
}

extension FridgeViewController: FridgeViewProtocol {

}

extension FridgeViewController {
    private func setupView() {
        title = "What's in your fridge?"
        view.addSubview(showSearchResultsButton)
        view.addSubview(tableView)
        setupSearchButton()
        setupTableView()
    }

    private func configNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:
                                FeedConstants.ViewController.Design.navigationTextColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.backgroundColor = FeedConstants.ViewController.Design.navBarBackgroundColor

        navigationController?.navigationBar.barTintColor = FeedConstants.ViewController.Design.navBarBarTintColor
        navigationController?.navigationBar.tintColor = FeedConstants.ViewController.Design.navBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true

        // need nav bar back view image to avoid some ios bag with search result controller frame on search bar tap
        navigationController?.navigationBar.setBackgroundImage(FeedConstants.ViewController.Image.navBarBackground,
                                                               for: .default)
        navigationController?.navigationBar.shadowImage = FeedConstants.ViewController.Image.navBarShadowImage
        navigationController?.view.backgroundColor = FeedConstants.ViewController.Design.navBarBarTintColor

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: showSearchResultsButton.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupSearchButton() {
        let buttonHeight = FridgeConstants.ViewController.Layout.searchButtonHeight
        NSLayoutConstraint.activate([
            showSearchResultsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            showSearchResultsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            showSearchResultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            showSearchResultsButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
