//
//  SearchResultCell.swift
//  dummyYummy
//
//  Created by badyi on 01.07.2021.
//

import UIKit

final class SearchResultRecipeCell: RoundedCollectionCellWithShadow {

    static let id = "SearchResultRecipeCell"

    private var imageView: ShimmerUIImageView = {
        UIImageViewBuilder()
            .backgroundColor(RecipeViewConstants.Cell.Design.backgroundColor)
            .buildWithShimmer()
    }()

    private var title: UILabelWithInsets = {
        UILabelBuilder()
            .backgroundColor(RecipeViewConstants.Cell.Design.titleBackgroundColor)
            .textColor(RecipeViewConstants.Cell.Design.titleColor)
            .setFont(RecipeViewConstants.Cell.Font.titleFont)
            .buildWithInsets()
    }()

    var isAnimated: Bool = false

    // MARK: - View lifecycle methods

    override func setupView() {
        super.setupView()
        shadowColor = RecipeViewConstants.Cell.Design.shadowColor
        cornerRadius = RecipeViewConstants.Cell.Layout.cornerRadius
        shadowRadius = RecipeViewConstants.Cell.Layout.shadowRadius
        shadowOpacity = RecipeViewConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = RecipeViewConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = RecipeViewConstants.Cell.Layout.shadowOffsetHeight

        contentView.addSubview(imageView)
        contentView.addSubview(title)
        setupImageView()
        setupTitle()
    }
}

// MARK: - View config methods
extension SearchResultRecipeCell {
    func startShimmerAnimations() {
        imageView.startShimmerAnimation()
    }

    func config(with recipe: Recipe) {
        self.title.text = recipe.title
        guard let imageData = recipe.imageData else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        self.imageView.image = image
        imageView.removeShimmerAnimation()
    }
}

// MARK: - Subviews setup methods
private extension SearchResultRecipeCell {
    func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupTitle() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}
