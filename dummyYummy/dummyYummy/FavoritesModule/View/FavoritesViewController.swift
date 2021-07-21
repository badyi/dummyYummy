//
//  FavoriteViewController.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

final class FavoritesViewController: RecipesViewController {

    var presenter: FavoritesPresenterProtocol?

    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func setupView() {
        title = "Favorite recipes"
        collectionView.delegate = self
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.id)
        view.addSubview(collectionView)
        setupSearchBar()
        setupCollectionView()
    }
}

private extension FavoritesViewController {
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = presenter as? UISearchResultsUpdating
        navigationItem.searchController = searchController
    }
}

extension FavoritesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.didEndDisplayingCell(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// Calculating cell size
        /// The calculation is mainly aimed at calculating the size of the title in the cell
        /// based on this, we calculate the entire size of cell
        var title = ""
        if let recipeTitle = presenter?.recipeTitle(at: indexPath) {
            title = recipeTitle
        }

        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = FavoriteCell.heightForCell(with: title, width: width)

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return FeedConstants.ViewController.Layout.minimumLineSpacing
    }
}
