//
//  FridgeSearchResultViewController.swift
//  dummyYummy
//
//  Created by badyi on 23.07.2021.
//

import UIKit

protocol FridgeSearchResultViewProtocol: RecipesViewProtocol {

}

final class FridgeSearchResultViewController: RecipesViewController {
    var presenter: FridgeSearchResultPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadRecipes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }

}

extension FridgeSearchResultViewController: FridgeSearchResultViewProtocol {

}

extension FridgeSearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.loadImageIfNeeded(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter?.cancelLoadImageIfNeeded(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRecipe(at: indexPath.row)
    }
}

extension FridgeSearchResultViewController: UICollectionViewDelegateFlowLayout {
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

extension FridgeSearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.recipesCount() ?? 0
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

extension FridgeSearchResultViewController {
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultID)
        collectionView.register(SearchResultRecipeCell.self, forCellWithReuseIdentifier: SearchResultRecipeCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionView()
    }
}
