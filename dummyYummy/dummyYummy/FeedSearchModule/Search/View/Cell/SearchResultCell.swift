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
            .backgroundColor(.blue)
            .buildWithShimmer()
    }()
    
    private var title: ShimmerUILabel = {
        UILabelBuilder()
            .backgroundColor(.systemRed.withAlphaComponent(0.5))
            .buildWithShimmer()
    }()
    
    // MARK: - View lifecycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        title.text = ""
    }
}

extension SearchResultCell {
    func config(with recipe: SearchRecipe) {
        self.title.text = recipe.title
        guard let imageData = recipe.imageData else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        self.imageView.image = image
    }
}

private extension SearchResultCell {
    func setupView() {
        shadowColor = FeedCellConstants.Design.shadowColor
        cornerRadius = FeedCellConstants.Layout.cornerRadius
        shadowRadius = FeedCellConstants.Layout.shadowRadius
        shadowOpacity = FeedCellConstants.Layout.shadowOpacity
        shadowOffsetWidth = FeedCellConstants.Layout.shadowOffsetWidth
        shadowOffsetHeight = FeedCellConstants.Layout.shadowOffsetHeight
        setupShadow()
        
        title.text = "hello lorem lorem loerm lorem"
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        setupImageView()
        setupTitle()
    }
    
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
