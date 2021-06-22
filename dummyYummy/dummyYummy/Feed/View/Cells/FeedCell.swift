//
//  FeedCell.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedCell: UICollectionViewCell {
    static let id = "FeedCell"
    
    private lazy var imageView: ShimmerUIImageView = {
        return UIImageViewBuilder()
            .backgroundColor(FeedCellColors.backgroundColor)
            .buildWithShimmer()
    }()
    
    lazy var title: ShimmerUILabel = {
        return UILabelBuilder()
            .setFont(FeedCellConstants.titleFont)
            .backgroundColor(FeedCellColors.backgroundColor)
            .textColor(FeedCellColors.titleColor)
            .buildWithShimmer()
    }()
    
    private lazy var healthScore: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedCellColors.backgroundColor)
            .textColor(FeedCellColors.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var minutes: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(FeedCellColors.backgroundColor)
            .textColor(FeedCellColors.additinalTextColor)
            .buildWithShimmer()
    }()
    
    private lazy var favorite: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedCellColors.backgroundColor)
            .setImage(UIImage(systemName: "suit.heart")!)
            .largeConfig(true)
            .tintColor(FeedCellColors.buttonTintColor)
            .buildWithShimmer()
    }()
    
    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedCellColors.backgroundColor)
            .largeConfig(true)
            .tintColor(FeedCellColors.buttonTintColor)
            .setImage(UIImage(systemName: "square.and.arrow.up")!)
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
        minutes.text = ""
        healthScore.text = ""
    }
    var isShimmerAnimatin: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: FeedCellConstants.cornerRadius
        ).cgPath
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
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
            imageView.image = UIImage(named: "noimage")!
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
        let horizontalInsets = FeedCellConstants.leadingSpace + FeedCellConstants.trailingSpace
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FeedCellConstants.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - horizontalInsets, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)
        
        /// the computed height needed for the titleLabel
        var height = rect.height + FeedCellConstants.imageHeight +
            (FeedCellConstants.verticalSpace * 2) +
            FeedCellConstants.minutesHeight +
            FeedCellConstants.healthScoreHeight +
            FeedCellConstants.bottomSpace +
            FeedCellConstants.topSpace
        
        /// in case  title is empty, we set the default size
        if title == "" {
            height += FeedCellConstants.minimalTitleHeight - rect.height
        }
        return height
    }
}

extension FeedCell {
    private func setupView() {
        configView()
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
    
    private func configView() {
        contentView.backgroundColor = FeedCellColors.backgroundColor
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = FeedCellConstants.cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = FeedCellConstants.cornerRadius
        layer.masksToBounds = false
        /// Apply a shadow
        layer.shadowRadius = FeedCellConstants.shadowRadius
        layer.shadowOpacity = FeedCellConstants.shadowOpacity
        layer.shadowColor = FeedCellColors.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: FeedCellConstants.shadowOffsetWidth, height: FeedCellConstants.shadowOffsetHeight)
    }
    
    private func setupImageViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: FeedCellConstants.imageHeight)
        ])
    }
    
    private func setupLabels() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FeedCellConstants.leadingSpace),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: FeedCellConstants.topSpace),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedCellConstants.trailingSpace),
            title.heightAnchor.constraint(greaterThanOrEqualToConstant: FeedCellConstants.minimalTitleHeight)
        ])
        
        NSLayoutConstraint.activate([
            healthScore.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            healthScore.topAnchor.constraint(equalTo: title.bottomAnchor, constant: FeedCellConstants.verticalSpace),
            healthScore.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedCellConstants.horizontalSpace),
            healthScore.heightAnchor.constraint(equalToConstant: FeedCellConstants.healthScoreHeight)
        ])
        
        NSLayoutConstraint.activate([
            minutes.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            minutes.topAnchor.constraint(equalTo: healthScore.bottomAnchor, constant: FeedCellConstants.verticalSpace),
            minutes.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: -FeedCellConstants.horizontalSpace),
            minutes.heightAnchor.constraint(equalToConstant: FeedCellConstants.minutesHeight)
        ])
    }
    
    private func setupButtons() {
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: healthScore.topAnchor),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedCellConstants.trailingSpace),
            favorite.widthAnchor.constraint(equalToConstant: FeedCellConstants.buttonWidth),
            favorite.heightAnchor.constraint(equalTo: favorite.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: healthScore.topAnchor),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor, constant: -FeedCellConstants.horizontalSpace),
            share.widthAnchor.constraint(equalToConstant: FeedCellConstants.buttonWidth),
            share.heightAnchor.constraint(equalTo: share.widthAnchor)
        ])
    }
}
