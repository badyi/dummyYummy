//
//  SearchViewController.swift
//  dummyYummy
//
//  Created by badyi on 20.06.2021.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    var navigationDelegate: SearchNavigationDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(.red)
            .delegate(self)
            .dataSource(presenter as? UICollectionViewDataSource)
            .setInsets(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
            .build()
        cv.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.id)
        return cv
    }()
    
    var presenter: SearchPresenterProtocol

    init(with presenter: SearchPresenterProtocol) {
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

extension SearchResultViewController: SearchViewProtocol {
    func setupView() {
        view.backgroundColor = .systemBlue
        setupCollectionView()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
    
    func configNavigation() {
        
    }
}

extension SearchResultViewController {
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

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.didEndDisplayCell(at: indexPath)
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - 24) / 2
        let height =  (collectionView.bounds.width - 24) / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter.updateSearchResult(text)
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        navigationDelegate?.didTapSearchSettingsButton(presenter.refinements)
    }
}
