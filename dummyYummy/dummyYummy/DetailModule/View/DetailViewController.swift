//
//  DetailViewController.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

enum DetailSections {
    case headerSection, characteristics, ingredientsAndInstrusctions
}

final class DetailViewController: UIViewController {

    var currentSelected: Int = 0

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionViewBuilder()
            .backgroundColor(DetailConstants.ViewController.Design.backgroundColor)
            .setInsets(DetailConstants.ViewController.Layout.collectionInsets)
            .delegate(self)
            .dataSource(self)
            .build()
        collectionView.register(DetailHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DetailHeader.id)
        collectionView.register(DetailCell.self,
                                forCellWithReuseIdentifier: DetailCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultID)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: UICollectionReusableView.defaultRVID)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: UICollectionReusableView.defaultRVID)
        collectionView.accessibilityIdentifier = AccessibilityIdentifiers.DetailViewController.collectionView
        return collectionView
    }()

    private let sections: [DetailSections] = [.headerSection, .characteristics, .ingredientsAndInstrusctions]

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
        setupCollectionView()
    }

    func configNavigationBar() {
        let design = DetailConstants.ViewController.Design.self
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = design.navBarBackgroundColor
    }
}

extension DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        // use footer as small space between sections
        if kind == UICollectionView.elementKindSectionFooter {
            let id = UICollectionReusableView.defaultRVID
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: id,
                                                                         for: indexPath)
            return footer
        }

        let headerKind = UICollectionView.elementKindSectionHeader
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind,
                                                                           withReuseIdentifier: DetailHeader.id,
                                                                           for: indexPath) as? DetailHeader else {
            let id = UICollectionReusableView.defaultRVID
            return collectionView.dequeueReusableSupplementaryView(ofKind: headerKind,
                                                                   withReuseIdentifier: id,
                                                                   for: indexPath)
        }
        header.backgroundColor = .clear

        // header with image and title
        if sections[indexPath.section] == .headerSection {

            // recipe.isFavorite = checkFavoriteStatus()
            guard let recipe = presenter?.getRecipe() else {
                return header
            }
            header.configView(with: recipe)

            header.handleFavoriteButtonTap = { [weak self] in
                self?.presenter?.handleFavoriteTap(at: indexPath)
            }
            return header

        // header with a button to expand
        } else if sections[indexPath.section] == .characteristics {

            guard let characteristics = presenter?.getCharacteristics() else {
                return header
            }
            header.configViewWith(title: "Characterisctics")
            // handle the tap  of button
            header.isExpanded = characteristics.isExpanded
            header.headerTapped = { [weak self] in
                self?.presenter?.headerTapped(indexPath.section)
            }

        // header with segment controll
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {

            header.configWithSegment(currentSelected)
            header.segmentSelectedValueChanged = { [weak self] value in
                self?.currentSelected = value
                self?.presenter?.segmentDidChange()
            }
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if sections[section] == .headerSection {
            return 0
        } else if sections[section] == .characteristics {
            guard let characteristics = presenter?.getCharacteristics() else {
                return 0
            }
            if characteristics.isExpanded {
                return characteristics.values.count
            }
            // if the section should not be expanded, return 0
            return 0
        } else if sections[section] == .ingredientsAndInstrusctions {
            guard let recipe = presenter?.getRecipe() else {
                return 0
            }
            if currentSelected == 0 {
                return recipe.ingredients?.count ?? 0
            } else if currentSelected == 1 {
                return recipe.instructions?.count ?? 0
            }
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id,
                                                            for: indexPath) as? DetailCell else {
            let id = UICollectionViewCell.defaultID
            return collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        }

        guard let characteristics = presenter?.getCharacteristics() else {
            return cell
        }
        // configuring cells for characteristics section
        if sections[indexPath.section] == .characteristics {
            cell.config(with: characteristics.values[indexPath.row])
            return cell
        // configuring cells for ingredients and instructions section
        } else if sections[indexPath.section] == .ingredientsAndInstrusctions {
            guard let recipe = presenter?.getRecipe() else {
                return cell
            }
            // configuring for ingredients
            if currentSelected == 0 {
                cell.config(with: recipe.ingredients?[indexPath.row] ?? "")
            // configuring for instructions
            } else if currentSelected == 1 {
                cell.config("Step \(indexPath.row + 1). ", with: recipe.instructions?[indexPath.row] ?? "")
            }
        }
        return cell
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
        } else if indexPath.section == 2, currentSelected == 0 {
            let text = presenter?.ingredientTitle(at: indexPath) ?? ""
            height = DetailCell.heightForCell(with: text, width: width)
        } else if indexPath.section == 2, currentSelected == 1 {
            let text = presenter?.instructionTitle(at: indexPath) ?? ""
            height = DetailCell.heightForCell(with: text, width: width)
        }
        return CGSize(width: width, height: height)
    }
}

private extension DetailViewController {
    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
