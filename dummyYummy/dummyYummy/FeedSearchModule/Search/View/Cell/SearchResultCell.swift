//
//  SearchResultCell.swift
//  dummyYummy
//
//  Created by badyi on 01.07.2021.
//

import UIKit

final class SearchResultCell: RoundedCollectionCellWithShadow {
    static let id = "SearchResultCell"
    
    private var imageView: ShimmerUIImageView = {
        UIImageViewBuilder()
            .backgroundColor(SearchResultConstants.Cell.Design.backgroundColor)
            .buildWithShimmer()
    }()
    
    private var title: UILabelWithInsets = {
        UILabelBuilder()
            .backgroundColor(SearchResultConstants.Cell.Design.titleBackgroundColor)
            .textColor(SearchResultConstants.Cell.Design.titleColor)
            .setFont(SearchResultConstants.Cell.Font.titleFont)
            .buildWithInsets()
    }()
    
    var isShimmerAnimatin: Bool = false
    
    // MARK: - View lifecycle methods

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        title.text = ""
    }
    
    override func setupView() {
        super.setupView()
        shadowColor = SearchResultConstants.Cell.Design.shadowColor
        cornerRadius = SearchResultConstants.Cell.Layout.cornerRadius
        shadowRadius = SearchResultConstants.Cell.Layout.shadowRadius
        shadowOpacity = SearchResultConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = SearchResultConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = SearchResultConstants.Cell.Layout.shadowOffsetHeight
       
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        setupImageView()
        setupTitle()
    }
}

extension SearchResultCell {
    func config(with recipe: FeedRecipe) {
        self.title.text = recipe.title
        guard let imageData = recipe.imageData else {
            imageView.startShimmerAnimation()
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        imageView.removeShimmerAnimation()
        self.imageView.image = image
    }
}

private extension SearchResultCell {
    
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
