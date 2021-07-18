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

// MARK: - FeedViewProtocol
extension FeedViewController: FeedViewProtocol {

    func setupView() {
        title = "Browes recipes"
        collectionView.accessibilityIdentifier = AccessibilityIdentifiers.FeedViewControlller.collectionView
        collectionView.delegate = self
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.prefetchDataSource = presenter as? UICollectionViewDataSourcePrefetching
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.id)
        
        setupCollectionView()
    }
}

extension FeedViewController {
    // MARK: - View setup methods


}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
        cell.accessibilityIdentifier = AccessibilityIdentifiers.FeedViewControlller.cell + "-\(indexPath.section)-\(indexPath.row)"
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.didEndDisplayingCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath)
    }
}

extension FeedPresenter: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            willDisplayCell(at: $0)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// Calculating cell size
        /// The calculation is mainly aimed at calculating the size of the title in the cell
        /// based on this, we calculate the entire size of cell
        var title = ""
        if let recipeTitle = presenter?.recipeTitle(at: indexPath) {
            title = recipeTitle
        }
        
        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = FeedCell.heightForCell(with: title, width: width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return FeedConstants.VC.Layout.minimumLineSpacing
    }
}
