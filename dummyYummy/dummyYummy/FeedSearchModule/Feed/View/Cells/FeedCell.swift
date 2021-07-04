//
//  FeedCell.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedCell: RoundedCollectionCellWithShadow {
    static let id = "FeedCell"
    
    private lazy var imageView: ShimmerUIImageView = {
        return UIImageViewBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .buildWithShimmer()
    }()
    
    lazy var title: ShimmerUILabel = {
        return UILabelBuilder()
            .setFont(FeedConstants.Cell.Font.titleFont)
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .textColor(FeedConstants.Cell.Design.titleColor)
            .buildWithShimmer()
    }()
    
    private lazy var healthScore: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .textColor(FeedConstants.Cell.Design.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var minutes: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .textColor(FeedConstants.Cell.Design.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var favorite: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .setImage(FeedConstants.Cell.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(FeedConstants.Cell.Design.buttonTintColor)
            .buildWithShimmer()
    }()
    
    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(FeedConstants.Cell.Design.buttonTintColor)
            .setImage(FeedConstants.Cell.Image.shareImage)
            .buildWithShimmer()
    }()
    
    var isShimmerAnimatin: Bool = false
    
    // MARK: - View lifecycle methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        title.text = ""
        minutes.text = ""
        healthScore.text = ""
    }
    
    override func setupView() {
        shadowColor = FeedConstants.Cell.Design.shadowColor
        cornerRadius = FeedConstants.Cell.Layout.cornerRadius
        shadowRadius = FeedConstants.Cell.Layout.shadowRadius
        shadowOpacity = FeedConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = FeedConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = FeedConstants.Cell.Layout.shadowOffsetHeight
        
        contentView.backgroundColor = FeedConstants.Cell.Design.backgroundColor

        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(healthScore)
        contentView.addSubview(minutes)
        contentView.addSubview(favorite)
        contentView.addSubview(share)
        setupImageViews()
        setupLabels()
        setupButtons()
        startAnimation()
    }
}

// MARK: - View setup methods
extension FeedCell {
    func stopAnimation() {
        title.removeShimmerAnimation()
        healthScore.removeShimmerAnimation()
        minutes.removeShimmerAnimation()
        
        favorite.removeShimmerAnimation()
        share.removeShimmerAnimation()
    }
    
    func stopImageViewAnimation() {
        imageView.removeShimmerAnimation()
    }
    
    func startAnimation() {
        imageView.startShimmerAnimation()
        title.startShimmerAnimation()
        healthScore.startShimmerAnimation()
        minutes.startShimmerAnimation()
        
        favorite.startShimmerAnimation()
        share.startShimmerAnimation()
    }
    
    func configView(with recipe: FeedRecipe) {
        title.text = recipe.title
        
        if let score = recipe.healthScore, let time = recipe.readyInMinutes {
            healthScore.text = "Health score: \(score)"
            minutes.text = "Cooking minutes: \(time)"
        }
    
        /// set default image if recipe dont have image url and remove shimmer animation
        if recipe.imageURL == nil {
            imageView.image = FeedConstants.Cell.Image.defaultCellImage
            imageView.removeShimmerAnimation()
            return
        }
        
        guard let imageData = recipe.imageData else { return }
        guard let image = UIImage(data: imageData) else { return }
        
        imageView.image = image
        imageView.removeShimmerAnimation()
    }
    
    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        /// insets from left and right edges
        let layoutConstants = FeedConstants.Cell.Layout.self
        let horizontalInsets = layoutConstants.leadingSpace + layoutConstants.trailingSpace
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FeedConstants.Cell.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - horizontalInsets, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)
        
        /// the computed height needed for the titleLabel
        var height = rect.height + layoutConstants.imageHeight +
            (layoutConstants.verticalSpace * 2) +
            layoutConstants.minutesHeight +
            layoutConstants.healthScoreHeight +
            layoutConstants.bottomSpace +
            layoutConstants.topSpace
        
        /// in case  title is empty, we set the default size
        if title == "" {
            height += layoutConstants.minimalTitleHeight - rect.height
        }
        return height
    }
}

private extension FeedCell {

    
    func setupImageViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.imageHeight)
        ])
    }
    
    func setupLabels() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FeedConstants.Cell.Layout.leadingSpace),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: FeedConstants.Cell.Layout.topSpace),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedConstants.Cell.Layout.trailingSpace),
            title.heightAnchor.constraint(greaterThanOrEqualToConstant: FeedConstants.Cell.Layout.minimalTitleHeight)
        ])
        
        NSLayoutConstraint.activate([
            healthScore.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            healthScore.topAnchor.constraint(equalTo: title.bottomAnchor, constant: FeedConstants.Cell.Layout.verticalSpace),
            healthScore.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
            healthScore.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.healthScoreHeight)
        ])
        
        NSLayoutConstraint.activate([
            minutes.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            minutes.topAnchor.constraint(equalTo: healthScore.bottomAnchor, constant: FeedConstants.Cell.Layout.verticalSpace),
            minutes.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
            minutes.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.minutesHeight)
        ])
    }
    
    func setupButtons() {
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: healthScore.topAnchor),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedConstants.Cell.Layout.trailingSpace),
            favorite.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            favorite.heightAnchor.constraint(equalTo: favorite.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: healthScore.topAnchor),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
            share.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            share.heightAnchor.constraint(equalTo: share.widthAnchor)
        ])
    }
}
