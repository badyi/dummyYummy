//
//  SearchViewController.swift
//  dummyYummy
//
//  Created by badyi on 20.06.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(.red)
            .delegate(self)
            //.dataSource(self)
            .setInsets(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            .build()
        return cv
    }()
    
    var presenter: SearchPresenterProtocol
    
    required init(with presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension SearchViewController: SearchViewProtocol {
    func setupView() {
        view.backgroundColor = .systemBlue
        setupCollectionView()
    }
    
    func reloadCollection() {
        
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        
    }
    
    func configNavigation() {
        
    }
}

extension SearchViewController {
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate {
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
}
