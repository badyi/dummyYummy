//
//  DetailViewController.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionViewBuilder()
            .backgroundColor(DetailConstants.VC.Design.backgroundColor)
            .setInsets(DetailConstants.VC.Layout.collectionInsets)
            .delegate(self)
            .dataSource(presenter as? UICollectionViewDataSource)
            .build()
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CVReusableView")
        cv.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.id)
        cv.register(CharacteristicsCell.self, forCellWithReuseIdentifier: CharacteristicsCell.id)
        return cv
    }()
    
    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
    }
}

extension DetailViewController: DetailViewProtocol {
    func reloadSection(_ section: Int) {
        collectionView.performBatchUpdates({
            collectionView.reloadSections(IndexSet(integer: section))
        }, completion: nil)
    }
    
    func setupView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

private extension DetailViewController {
    
    func configNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = DetailConstants.VC.Design.navBarBackgroundColor
    }
}

extension DetailViewController: UICollectionViewDelegate {    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            let title = presenter.headerTitle()
            let height = DetailHeader.heightForCell(with: title, width: collectionView.bounds.width)
            return CGSize(width: collectionView.bounds.width, height: height)
        } else if section == 1 || section == 2 {
            return CGSize(width:collectionView.bounds.width, height: DetailConstants.VC.Layout.headerWithTitleHeight)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        DetailConstants.VC.Layout.minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: DetailConstants.VC.Layout.footerHeight)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: DetailConstants.VC.Layout.characteristicsCellHeight)
    }
}
