//
//  DetailViewController.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

final class DetailViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionViewBuilder()
            .backgroundColor(DetailConstants.ViewController.Design.backgroundColor)
            .setInsets(DetailConstants.ViewController.Layout.collectionInsets)
            .delegate(self)
            .dataSource(presenter as? UICollectionViewDataSource)
            .build()
        collectionView.register(DetailHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DetailHeader.id)
        collectionView.register(DetailCell.self,
                                forCellWithReuseIdentifier: DetailCell.id)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "CVFooterView")
        collectionView.accessibilityIdentifier = AccessibilityIdentifiers.DetailViewController.collectionView
        return collectionView
    }()

    var presenter: DetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

extension DetailViewController: DetailViewProtocol {
    func reloadCollection() {
        collectionView.reloadData()
    }

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

    func configNavigationBar() {
        let design = DetailConstants.ViewController.Design.self
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = design.navBarBackgroundColor
    }
}

extension DetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        if section == 0 {
            let title = presenter?.headerTitle() ?? ""
            let height = DetailHeader.heightForHeaderCellWithImage(with: title, width: width)
            return CGSize(width: width, height: height)
        } else if section == 1 || section == 2 {
            return CGSize(width: width, height: DetailConstants.ViewController.Layout.headerWithTitleHeight)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        DetailConstants.ViewController.Layout.minimumLineSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        DetailConstants.ViewController.Layout.minimumInteritemSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right

        return CGSize(width: width, height: DetailConstants.ViewController.Layout.footerHeight)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right

        var height: CGFloat = 0
        if indexPath.section == 1 {
            let text = presenter?.characteristic(at: indexPath) ?? ""
            let height = DetailCell.heightForCell(with: text, width: width)
            return CGSize(width: width, height: height)
        } else if indexPath.section == 2, presenter?.currentSelectedSegment() == 0 {
            let text = presenter?.ingredientTitle(at: indexPath) ?? ""
            height = DetailCell.heightForCell(with: text, width: width)
        } else if indexPath.section == 2, presenter?.currentSelectedSegment() == 1 {
            let text = presenter?.instructionTitle(at: indexPath) ?? ""
            height = DetailCell.heightForCell(with: text, width: width)
        }
        return CGSize(width: width, height: height)
    }
}
