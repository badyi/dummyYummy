//
//  RecipeBigCell.swift
//  dummyYummy
//
//  Created by badyi on 15.07.2021.
//

import UIKit

class RecipeBigCell: RoundedCollectionCellWithShadow {
    var cellBackgroundColor = BaseRecipeConstants.BigCell.Design.backgroundColor
    var titleFont = BaseRecipeConstants.BigCell.Font.titleFont
    var titleColor = BaseRecipeConstants.BigCell.Design.titleColor
    var additionalTextColor = BaseRecipeConstants.BigCell.Design.additinalTextColor
    var largeConfig = true
    var buttonTintColor = BaseRecipeConstants.BigCell.Design.buttonTintColor
    var shareImage = BaseRecipeConstants.BigCell.Image.shareImage
    var favoriteImage = BaseRecipeConstants.BigCell.Image.favoriteImage

    var favoriteButtonTapHandle: (() -> Void)?
    var shareButtonTapHandle: (() -> Void)?

    lazy var imageView: ShimmerUIImageView = {
        return UIImageViewBuilder()
            .backgroundColor(cellBackgroundColor)
            .buildWithShimmer()
    }()

    lazy var titleLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .setFont(titleFont)
            .backgroundColor(cellBackgroundColor)
            .textColor(BaseRecipeConstants.BigCell.Design.titleColor)
            .buildWithShimmer()
    }()

    lazy var healthScoreLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(BaseRecipeConstants.BigCell.Design.backgroundColor)
            .textColor(titleColor)
            .buildWithShimmer()
    }()

    lazy var minutesLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .backgroundColor(cellBackgroundColor)
            .textColor(additionalTextColor)
            .buildWithShimmer()
    }()

    lazy var shareButton: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(cellBackgroundColor)
            .largeConfig(largeConfig)
            .tintColor(buttonTintColor)
            .setImage(shareImage)
            .buildWithShimmer()
    }()

    lazy var favoriteButton: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(cellBackgroundColor)
            .setImage(favoriteImage)
            .largeConfig(largeConfig)
            .tintColor(buttonTintColor)
            .buildWithShimmer()
    }()

    var isShimmerAnimatin: Bool = false

    /// stop shimmer animation in all subviews except image view
    func stopAnimation() {
        titleLabel.removeShimmerAnimation()
        healthScoreLabel.removeShimmerAnimation()
        minutesLabel.removeShimmerAnimation()

        favoriteButton.removeShimmerAnimation()
        shareButton.removeShimmerAnimation()
    }

    /// stop shimmer animation in image view
    func stopImageViewAnimation() {
        imageView.removeShimmerAnimation()
    }

    /// start all shimmer animations
    func startAnimation() {
        imageView.startShimmerAnimation()
        titleLabel.startShimmerAnimation()
        healthScoreLabel.startShimmerAnimation()
        minutesLabel.startShimmerAnimation()

        favoriteButton.startShimmerAnimation()
        shareButton.startShimmerAnimation()
    }

    override func setupView() {
        super.setupView()

        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        /// config shadow constants
        shadowColor = BaseRecipeConstants.BigCell.Design.shadowColor
        cornerRadius = BaseRecipeConstants.BigCell.Layout.cornerRadius
        shadowRadius = BaseRecipeConstants.BigCell.Layout.shadowRadius
        shadowOpacity = BaseRecipeConstants.BigCell.Layout.shadowOpacity
        shadowOffsetWidth = BaseRecipeConstants.BigCell.Layout.shadowOffsetWidth
        shadowOffsetHeight = BaseRecipeConstants.BigCell.Layout.shadowOffsetHeight

        contentView.backgroundColor = BaseRecipeConstants.BigCell.Design.backgroundColor

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(healthScoreLabel)
        contentView.addSubview(minutesLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(shareButton)

        setupImageViews()
        setupLabels()
        setupButtons()
        startAnimation()
    }

    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        /// insets from left and right edges
        let layoutConstants = BaseRecipeConstants.BigCell.Layout.self
        let horizontalInsets = layoutConstants.leadingSpace + layoutConstants.trailingSpace

        let attributedString = NSAttributedString(string: title,
                                                  attributes: [NSAttributedString.Key.font:
                                                                BaseRecipeConstants.BigCell.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - horizontalInsets, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)

        /// The computed height needed for the titleLabel
        var height = rect.height + layoutConstants.imageHeight +
            (layoutConstants.verticalSpace * 2) +
            layoutConstants.minutesHeight +
            layoutConstants.healthScoreHeight +
            layoutConstants.bottomSpace +
            layoutConstants.topSpace

        /// In case  title is empty, we set the default size
        if title == "" {
            height += layoutConstants.minimalTitleHeight - rect.height
        }
        return height
    }

    func configView(with recipe: Recipe) {
        titleLabel.text = recipe.title

        if let score = recipe.healthScore, let time = recipe.readyInMinutes {
            healthScoreLabel.text = "Health score: \(score)"
            minutesLabel.text = "Cooking minutes: \(time)"
        }

        if recipe.isFavorite {
            favoriteButton.tintColor = FeedConstants.Cell.Design.favoriteButtonTintColor
            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImageFill, for: .normal)
        } else {
            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImage, for: .normal)
            favoriteButton.tintColor = BaseRecipeConstants.BigCell.Design.buttonTintColor
        }

        // set default image if recipe dont have image url and remove shimmer animation
        if recipe.imageURL == nil {
            imageView.image = FeedConstants.Cell.Image.defaultCellImage
            favoriteButton.isUserInteractionEnabled = true
            imageView.removeShimmerAnimation()
            return
        }

        guard let imageData = recipe.imageData else { return }
        guard let image = UIImage(data: imageData) else { return }
        imageView.image = image
        favoriteButton.isUserInteractionEnabled = true
        imageView.removeShimmerAnimation()
    }
}

extension RecipeBigCell {
    func setupImageViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: BaseRecipeConstants.BigCell.Layout.imageHeight)
        ])
    }

    func setupLabels() {
        let layout = BaseRecipeConstants.BigCell.Layout.self
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: layout.leadingSpace),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: layout.topSpace),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -layout.trailingSpace),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: layout.minimalTitleHeight)
        ])

        NSLayoutConstraint.activate([
            healthScoreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            healthScoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: layout.verticalSpace),
            healthScoreLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor,
                                                       constant: -layout.horizontalSpace),
            healthScoreLabel.heightAnchor.constraint(equalToConstant: layout.healthScoreHeight)
        ])

        NSLayoutConstraint.activate([
            minutesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            minutesLabel.topAnchor.constraint(equalTo: healthScoreLabel.bottomAnchor,
                                              constant: layout.verticalSpace),
            minutesLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor,
                                                   constant: -layout.horizontalSpace),
            minutesLabel.heightAnchor.constraint(equalToConstant: layout.minutesHeight)
        ])
    }

    func setupButtons() {
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: healthScoreLabel.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -BaseRecipeConstants.BigCell.Layout.trailingSpace),
            favoriteButton.widthAnchor.constraint(equalToConstant: BaseRecipeConstants.BigCell.Layout.buttonWidth),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: healthScoreLabel.topAnchor),
            shareButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor,
                                                  constant: -BaseRecipeConstants.BigCell.Layout.horizontalSpace),
            shareButton.widthAnchor.constraint(equalToConstant: BaseRecipeConstants.BigCell.Layout.buttonWidth),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ])
    }
}

private extension RecipeBigCell {
    @objc func favoriteButtonTapped() {
        favoriteButtonTapHandle?()
    }
}
