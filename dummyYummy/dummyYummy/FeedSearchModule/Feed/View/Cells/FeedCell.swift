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
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .buildWithShimmer()
    }()
    
    lazy var title: ShimmerUILabel = {
        return UILabelBuilder()
            .setFont(FeedCellConstants.Font.titleFont)
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .textColor(FeedCellConstants.Design.titleColor)
            .buildWithShimmer()
    }()
    
    private lazy var healthScore: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .textColor(FeedCellConstants.Design.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var minutes: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .textColor(FeedCellConstants.Design.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var favorite: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .setImage(FeedCellConstants.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(FeedCellConstants.Design.buttonTintColor)
            .buildWithShimmer()
    }()
    
    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedCellConstants.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(FeedCellConstants.Design.buttonTintColor)
            .setImage(FeedCellConstants.Image.shareImage)
            .buildWithShimmer()
    }()
    
    var isShimmerAnimatin: Bool = false
    
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
        minutes.text = ""
        healthScore.text = ""
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
        healthScore.text = "Health score: \(recipe.healthScore)"
        minutes.text = "Cooking minutes: \(recipe.readyInMinutes)"
    
        /// set default image if recipe dont have image url and remove shimmer animation
        if recipe.image == nil {
            imageView.image = FeedCellConstants.Image.defaultCellImage
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
        let layoutConstants = FeedCellConstants.Layout.self
        let horizontalInsets = layoutConstants.leadingSpace + layoutConstants.trailingSpace
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FeedCellConstants.Font.titleFont])
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
    func setupView() {
        shadowColor = FeedCellConstants.Design.shadowColor
        cornerRadius = FeedCellConstants.Layout.cornerRadius
        shadowRadius = FeedCellConstants.Layout.shadowRadius
        shadowOpacity = FeedCellConstants.Layout.shadowOpacity
        shadowOffsetWidth = FeedCellConstants.Layout.shadowOffsetWidth
        shadowOffsetHeight = FeedCellConstants.Layout.shadowOffsetHeight
        setupShadow()
        
        contentView.backgroundColor = FeedCellConstants.Design.backgroundColor

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
    
    func setupImageViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: FeedCellConstants.Layout.imageHeight)
        ])
    }
    
    func setupLabels() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FeedCellConstants.Layout.leadingSpace),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: FeedCellConstants.Layout.topSpace),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedCellConstants.Layout.trailingSpace),
            title.heightAnchor.constraint(greaterThanOrEqualToConstant: FeedCellConstants.Layout.minimalTitleHeight)
        ])
        
        NSLayoutConstraint.activate([
            healthScore.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            healthScore.topAnchor.constraint(equalTo: title.bottomAnchor, constant: FeedCellConstants.Layout.verticalSpace),
            healthScore.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedCellConstants.Layout.horizontalSpace),
            healthScore.heightAnchor.constraint(equalToConstant: FeedCellConstants.Layout.healthScoreHeight)
        ])
        
        NSLayoutConstraint.activate([
            minutes.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            minutes.topAnchor.constraint(equalTo: healthScore.bottomAnchor, constant: FeedCellConstants.Layout.verticalSpace),
            minutes.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedCellConstants.Layout.horizontalSpace),
            minutes.heightAnchor.constraint(equalToConstant: FeedCellConstants.Layout.minutesHeight)
        ])
    }
    
    func setupButtons() {
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: healthScore.topAnchor),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedCellConstants.Layout.trailingSpace),
            favorite.widthAnchor.constraint(equalToConstant: FeedCellConstants.Layout.buttonWidth),
            favorite.heightAnchor.constraint(equalTo: favorite.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: healthScore.topAnchor),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor, constant: -FeedCellConstants.Layout.horizontalSpace),
            share.widthAnchor.constraint(equalToConstant: FeedCellConstants.Layout.buttonWidth),
            share.heightAnchor.constraint(equalTo: share.widthAnchor)
        ])
    }
}
