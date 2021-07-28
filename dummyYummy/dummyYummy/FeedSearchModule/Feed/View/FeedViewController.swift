//
//  ViewController.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedViewController: RecipesViewController {

    var presenter: FeedPresenterProtocol?

    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadRandomRecipes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
        reloadVisibleCells()
        presenter?.loadRandomRecipesIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopVisibleCellsAnimation()
    }
}

// MARK: - FeedViewProtocol
extension FeedViewController: FeedViewProtocol {
    func setupView() {
        title = "Browse recipes"
        navigationItem.searchController?.searchBar.placeholder = "Search recipes"
        collectionView.accessibilityIdentifier = AccessibilityIdentifiers.FeedViewControlller.collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultID)

        view.addSubview(collectionView)
        setupCollectionView()
    }

    func setSearchController(_ searchController: UISearchController) {
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.definesPresentationContext = true

        searchController.searchBar.searchBarStyle = .minimal

        navigationItem.searchController = searchController

        let textColor = FeedConstants.ViewController.Design.searchTextColor
        navigationItem.searchController?.searchBar.searchTextField.textColor = textColor
    }
}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.prepareRecipe(at: indexPath.row)
        let accesibilityId = AccessibilityIdentifiers.FeedViewControlller.cell
        let index = "-\(indexPath.section)-\(indexPath.row)"
        cell.accessibilityIdentifier = accesibilityId + index
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.noNeedPrepearRecipe(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRecipe(at: indexPath.row)
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // in case the recipes haven't loaded yet
        // we put a few fake cells with animations
        guard let count = presenter?.recipesCount() else { return 0 }
        if count < 1 {
            return FeedConstants.ViewController.Layout.emptyCellsCount
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.id,
                                                            for: indexPath) as? FeedCell else {

            return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.defaultID,
                                                      for: indexPath)
        }

        cell.startAnimation()
        if let recipe = presenter?.recipe(at: indexPath.row) {
            recipe.isFavorite = presenter?.isFavorite(at: indexPath.row) ?? false
            cell.configView(with: recipe)
            cell.stopAnimation()
            cell.handleFavoriteButtonTap = { [weak self] in
                self?.presenter?.handleFavoriteTap(at: indexPath.row)
            }
            cell.handleShareButtonTap = { [weak self] in
                self?.presenter?.handleShareTap(at: indexPath.row)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {

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
        let height = FeedCell.heightForCell(with: title, width: width)

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return FeedConstants.ViewController.Layout.minimumLineSpacing
    }
}

extension FeedViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            presenter?.prepareRecipe(at: $0.row)
        }
    }
}
