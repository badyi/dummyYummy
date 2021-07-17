//
//  RecipesViewController.swift
//  dummyYummy
//
//  Created by badyi on 17.07.2021.
//

import UIKit

class RecipesViewController: UIViewController {
    var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(BaseRecipeConstants.VC.Design.backgroundColor)
            .setInsets(BaseRecipeConstants.VC.Layout.collectionInsets)
            .build()
        return cv
    }()
}

extension RecipesViewController: RecipesViewProtocol {
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func reloadVisibleCells() {
        /// if we don't use perform batch, large title is hidden after reloading visible items
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
    
    func reloadCollection() {
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

        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: reloadIndexes)
        }, completion: nil)
    }
    
    func configNavigation() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: FeedConstants.VC.Design.navigationTextColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.backgroundColor = FeedConstants.VC.Design.navBarBackgroundColor

        navigationController?.navigationBar.barTintColor = FeedConstants.VC.Design.navBarBarTintColor
        navigationController?.navigationBar.tintColor = FeedConstants.VC.Design.navBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true

        /// need nav bar back view image to avoid some ios bag with search result controller frame on search bar tap
        navigationController?.navigationBar.setBackgroundImage(FeedConstants.VC.Image.navBarBackground, for: .default)
        navigationController?.navigationBar.shadowImage = FeedConstants.VC.Image.navBarShadowImage
        navigationController?.view.backgroundColor = FeedConstants.VC.Design.navBarBarTintColor

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }
}
