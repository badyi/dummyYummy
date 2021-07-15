//
//  FeedCell.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedCell: RecipeBigCell {
    static let id = "FeedCell"

    // MARK: - View lifecycle methods
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        minutesLabel.text = ""
        healthScoreLabel.text = ""
        favoriteButton.tintColor = FeedConstants.Cell.Design.buttonTintColor
    }
    
    override func setupView() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        /// need to be user not interactive to avoid saving to core data without image
        /// it will be not interactive until cell is fully configured
        favoriteButton.isUserInteractionEnabled = false
        
        imageView.backgroundColor = FeedConstants.Cell.Design.backgroundColor

        titleLabel.font = FeedConstants.Cell.Font.titleFont
        titleLabel.backgroundColor = FeedConstants.Cell.Design.backgroundColor
        titleLabel.textColor = FeedConstants.Cell.Design.titleColor
 
        
        healthScoreLabel.backgroundColor = FeedConstants.Cell.Design.backgroundColor
        healthScoreLabel.textColor = FeedConstants.Cell.Design.additinalTextColor
 
        minutesLabel.backgroundColor = FeedConstants.Cell.Design.backgroundColor
        minutesLabel.textColor = FeedConstants.Cell.Design.additinalTextColor
        
        shareButton.backgroundColor = FeedConstants.Cell.Design.backgroundColor
        shareButton.tintColor = FeedConstants.Cell.Design.buttonTintColor
        shareButton.setImage(FeedConstants.Cell.Image.shareImage, for: .normal)
        
        favoriteButton.backgroundColor = FeedConstants.Cell.Design.backgroundColor
        favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImage, for: .normal)
        favoriteButton.tintColor = FeedConstants.Cell.Design.buttonTintColor
  
        shadowColor = FeedConstants.Cell.Design.shadowColor
        cornerRadius = FeedConstants.Cell.Layout.cornerRadius
        shadowRadius = FeedConstants.Cell.Layout.shadowRadius
        shadowOpacity = FeedConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = FeedConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = FeedConstants.Cell.Layout.shadowOffsetHeight
        
        contentView.backgroundColor = FeedConstants.Cell.Design.backgroundColor

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(healthScoreLabel)
        contentView.addSubview(minutesLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(shareButton)
        
        setConstraints()
        setupImageViews()
        setupLabels()
        setupButtons()
        startAnimation()
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

// MARK: - View setup methods
extension FeedCell {
    func configView(with recipe: Recipe) {
        titleLabel.text = recipe.title
        
        if let score = recipe.healthScore, let time = recipe.readyInMinutes {
            healthScoreLabel.text = "Health score: \(score)"
            minutesLabel.text = "Cooking minutes: \(time)"
        }
    
        if recipe.isFavorite {
            favoriteButton.tintColor = .red
            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImageFill, for: .normal)
        } else {
            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImage, for: .normal)
        }
        
        /// set default image if recipe dont have image url and remove shimmer animation
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

// MARK: - Setup UI elements
private extension FeedCell {
    func setConstraints() {
        imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.imageHeight)
        ]
        
        titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FeedConstants.Cell.Layout.leadingSpace),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: FeedConstants.Cell.Layout.topSpace),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedConstants.Cell.Layout.trailingSpace),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: FeedConstants.Cell.Layout.minimalTitleHeight)
        ]
        
        minutesLabelConstraints = [
            minutesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            minutesLabel.topAnchor.constraint(equalTo: healthScoreLabel.bottomAnchor, constant: FeedConstants.Cell.Layout.verticalSpace),
            minutesLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
            minutesLabel.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.minutesHeight)
        ]
        
        favoriteButtonConstraints = [
            favoriteButton.topAnchor.constraint(equalTo: healthScoreLabel.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedConstants.Cell.Layout.trailingSpace),
            favoriteButton.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor)
        ]
        
        shareButtonConstraints = [
            shareButton.topAnchor.constraint(equalTo: healthScoreLabel.topAnchor),
            shareButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
            shareButton.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ]
        
        healthScoreLabelConstraints = [
                healthScoreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                healthScoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: FeedConstants.Cell.Layout.verticalSpace),
                healthScoreLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -FeedConstants.Cell.Layout.horizontalSpace),
                healthScoreLabel.heightAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.healthScoreHeight)
        ]
    }
}

private extension FeedCell {
    @objc func favoriteButtonTapped() {
        favoriteButtonTapHandle?()
    }
}
