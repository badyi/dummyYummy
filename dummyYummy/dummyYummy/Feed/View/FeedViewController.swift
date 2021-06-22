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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

// MARK: - FeedViewProtocol
extension FeedViewController: FeedViewProtocol {
    func setupView() {
        title = "Browes food"
        definesPresentationContext = true
        setupCollectionView()
        setupNavigation()
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
    
    private func setupNavigation() {
    }
    
    func configNavigation() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.wisteria]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.backgroundColor = FeedViewControllerColors.navBarBackgroundColor
        
        navigationController?.navigationBar.barTintColor = FeedViewControllerColors.navBarBarTintColor
        navigationController?.navigationBar.tintColor = FeedViewControllerColors.navBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        /// need nav bar back view image to avoid some ios bag with search result controller frame on search bar tap
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = FeedViewControllerColors.navBarBarTintColor
        
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
        presenter.didEndDisplayCell(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// in case the recipes haven't loaded yet
        /// we put a few fake cells with animations
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

// MARK: - UISearchBarDelegate
//extension FeedViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        navigationController?.pushViewController(SearchViewController(), animated: false)
//    }
//}
