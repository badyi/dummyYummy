//
//  SearchViewController.swift
//  dummyYummy
//
//  Created by badyi on 20.06.2021.
//

import UIKit

final class SearchResultViewController: RecipesViewController {

    var presenter: SearchPresenterProtocol?

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension SearchResultViewController: SearchViewProtocol {
}

extension SearchResultViewController {
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultID)
        collectionView.register(SearchResultRecipeCell.self, forCellWithReuseIdentifier: SearchResultRecipeCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = SearchResultConstants.ViewController.Design.backgroundColor
        setupCollectionView()
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.recipesCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultRecipeCell.id,
                                                            for: indexPath) as? SearchResultRecipeCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.defaultID,
                                                      for: indexPath)
        }

        cell.startShimmerAnimations()
        if let recipe = presenter?.recipe(at: indexPath.row) {
            cell.config(with: recipe)
        }

        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.willDisplayRecipe(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.didEndDisplayRecipe(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRecipe(at: indexPath.row)
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let horizontalInsets = collectionView.contentInset.left + collectionView.contentInset.right
        let lineSpace = SearchResultConstants.ViewController.Layout.minimumLineSpacingForSection
        let interSpace = SearchResultConstants.ViewController.Layout.minimumInteritemSpacingForSection
        let cellsPerLine = SearchResultConstants.ViewController.Layout.cellsPerLine

        let width = (collectionView.bounds.width - (horizontalInsets + interSpace)) / cellsPerLine
        let height = (collectionView.bounds.width - (horizontalInsets + lineSpace)) / cellsPerLine
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        SearchResultConstants.ViewController.Layout.minimumInteritemSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        SearchResultConstants.ViewController.Layout.minimumInteritemSpacingForSection
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.loadRecipes()
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter?.updateSearchText(text)
    }
}
