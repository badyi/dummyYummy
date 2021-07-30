//
//  RecipesViewController.swift
//  dummyYummy
//
//  Created by badyi on 17.07.2021.
//

import UIKit

class RecipesViewController: UIViewController, RecipesViewProtocol {

    var collectionView: UICollectionView = {
        let collectionView = UICollectionViewBuilder()
            .backgroundColor(RecipeViewConstants.ViewController.Design.backgroundColor)
            .setInsets(RecipeViewConstants.ViewController.Layout.collectionInsets)
            .build()
        return collectionView
    }()

    var refreshControl: UIRefreshControl = {
        UIRefreshControl()
    }()

    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func reloadVisibleCells() {
        // if we don't use perform batch, large title is hidden after reloading visible items
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        }, completion: nil)
    }

    func stopVisibleCellsAnimation() {
        collectionView.visibleCells.forEach {
            ($0 as? RecipeBigCell)?.stopAnimation()
            ($0 as? RecipeBigCell)?.stopImageViewAnimation()
        }
    }

    func reloadCollectionView() {
        if let refresh = collectionView.refreshControl, refresh.isRefreshing == true {
            refreshControl.endRefreshing()
        }
        collectionView.reloadData()
    }

    func reloadItems(at indexPaths: [IndexPath]) {
        var reloadIndexes: [IndexPath] = []
        let currentVisibleItems = collectionView.indexPathsForVisibleItems
        indexPaths.forEach {
            if currentVisibleItems.contains($0) {
                reloadIndexes.append($0)
            }
        }
        collectionView.reloadItems(at: reloadIndexes)
    }

    func configNavigation() {
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

    func setupRefresh() {
        refreshControl.tintColor = Colors.wisteria
        collectionView.refreshControl = refreshControl
    }
}
