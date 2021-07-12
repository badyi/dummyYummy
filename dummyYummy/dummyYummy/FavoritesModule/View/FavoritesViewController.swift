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
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.id)
        cv.prefetchDataSource = presenter as? UICollectionViewDataSourcePrefetching
        return cv
    }()
    
    var presenter: FavoritesPresenterProtocol!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.didEndDisplayingCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCellAt(indexPath)
    }
}
