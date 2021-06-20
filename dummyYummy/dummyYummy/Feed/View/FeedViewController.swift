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
            .backgroundColor(FeedViewControllerColors.backgroundColor)
            .delegate(self)
            .dataSource(self)
            .setInsets(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            .build()
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.id)
        return cv
    }()
    
    var presenter: FeedPresenterProtocol
    
    required init(with presenter: FeedPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        //definesPresentationContext = true
    }
}

// MARK: - FeedViewProtocol
extension FeedViewController: FeedViewProtocol {
    func setupView() {
        setupCollectionView()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
}

extension FeedViewController {
    // MARK: - View setup methods
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.didEndDisplayCell(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// I
        presenter.recipesCount() == 0 ? 10 : presenter.recipesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.id, for: indexPath) as! FeedCell
        
        cell.startAnimation()
        if let recipe = presenter.recipe(at: indexPath) {
            cell.configView(with: recipe)
            cell.stopAnimation()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// Вычисление размера ячейки
        /// Расчет в основном направлен на расчет размера  тайтла в ячейке
        /// и исходя из его размера он добавляет его размер
        var title = ""
        if let recipe = presenter.recipe(at: indexPath) {
            title = recipe.title
        }
        
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = FeedCell.heightForCell(with: title, width: width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
