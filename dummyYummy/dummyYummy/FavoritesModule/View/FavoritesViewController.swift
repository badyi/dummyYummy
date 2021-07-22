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
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
        presenter?.retriveRecipes()
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
}

private extension FavoritesViewController {
    func setupView() {
        title = "Favorite recipes"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.id)
        view.addSubview(collectionView)
        setupSearchBar()
        setupCollectionView()
    }

    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.recipesCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.id,
                                                            for: indexPath) as? FavoriteCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }

        guard let recipe = presenter?.recipe(at: indexPath.row) else {
            return cell
        }

        cell.configView(with: recipe)

        cell.favoriteButtonTapHandle = { [weak self] in
            self?.presenter?.handleFavoriteTap(at: indexPath.row)
        }
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegate {

//    func collectionView(_ collectionView: UICollectionView,
//                        willDisplay cell: UICollectionViewCell,
//                        forItemAt indexPath: IndexPath) {
//        presenter?.willDisplayCell(at: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        didEndDisplaying cell: UICollectionViewCell,
//                        forItemAt indexPath: IndexPath) {
//        presenter?.didEndDisplayingCell(at: indexPath)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRecipe(at: indexPath.row)
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
        if let recipeTitle = presenter?.recipeTitle(at: indexPath.row) {
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

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter?.updateSearchText(text)
    }
}
