//
//  FavoriteViewController.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(FeedConstants.VC.Design.backgroundColor)
            .delegate(self)
            .dataSource(presenter as? UICollectionViewDataSource)
            .setInsets(FeedConstants.VC.Layout.collectionInsets)
            .build()
        cv.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.id)
        //cv.prefetchDataSource = presenter as? UICollectionViewDataSourcePrefetching
        return cv
    }()
    
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
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func setupView() {
        setupCollectionView()
    }
}

private extension FavoritesViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.didEndDisplayingCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return FeedConstants.VC.Layout.minimumLineSpacing
    }
}
