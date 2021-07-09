//
//  ViewController.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(FeedConstants.VC.Design.backgroundColor)
            .delegate(self)
            .dataSource(presenter as? UICollectionViewDataSource)
            .setInsets(FeedConstants.VC.Layout.collectionInsets)
            .build()
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.id)
        //cv.prefetchDataSource = presenter as? UICollectionViewDataSourcePrefetching
        return cv
    }()
    
    var presenter: FeedPresenterProtocol!
    
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

// MARK: - FeedViewProtocol
extension FeedViewController: FeedViewProtocol {
    
    func reloadVisibleCells() {
        /// if we don't use perform batch, large title is hidden after reloading visible items
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        }, completion: nil)
    }
    
    func stopVisibleCellsAnimation() {
        collectionView.visibleCells.forEach {
            ($0 as? FeedCell)?.stopAnimation()
            ($0 as? FeedCell)?.stopImageViewAnimation()
        }
    }
    
    func setupView() {
        title = "Browes recipes"
        setupCollectionView()
    }
    
    func reloadCollection() {
       // collectionView.performBatchUpdates({
        collectionView.reloadData()
        //}, completion: nil)
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
    
//    func reloadItems(at indexPaths: [IndexPath]) {
//        var reloadIndexes: [IndexPath] = []
//        let currentVisibleItems = collectionView.indexPathsForVisibleItems
//        indexPaths.forEach {
//            if currentVisibleItems.contains($0) {
//                reloadIndexes.append($0)
//            }
//        }
//
//        collectionView.performBatchUpdates({
//            collectionView.reloadItems(at: reloadIndexes)
//        }, completion: nil)
//    }
}

extension FeedViewController {
    // MARK: - View setup methods
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    
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
        if let recipe = presenter.recipe(at: indexPath) {
            title = recipe.title
        }
        
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = FeedCell.heightForCell(with: title, width: width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return FeedConstants.VC.Layout.minimumLineSpacing
    }
}
