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
            .backgroundColor(BaseRecipeConstants.Cell.Design.backgroundColor)
            .buildWithShimmer()
    }()

    private var title: UILabelWithInsets = {
        UILabelBuilder()
            .backgroundColor(BaseRecipeConstants.Cell.Design.titleBackgroundColor)
            .textColor(BaseRecipeConstants.Cell.Design.titleColor)
            .setFont(BaseRecipeConstants.Cell.Font.titleFont)
            .buildWithInsets()
    }()

    var isShimmerAnimatin: Bool = false

    // MARK: - View lifecycle methods

    override func setupView() {
        super.setupView()
        shadowColor = BaseRecipeConstants.Cell.Design.shadowColor
        cornerRadius = BaseRecipeConstants.Cell.Layout.cornerRadius
        shadowRadius = BaseRecipeConstants.Cell.Layout.shadowRadius
        shadowOpacity = BaseRecipeConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = BaseRecipeConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = BaseRecipeConstants.Cell.Layout.shadowOffsetHeight

        contentView.addSubview(imageView)
        contentView.addSubview(title)
        setupImageView()
        setupTitle()
    }
}

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
