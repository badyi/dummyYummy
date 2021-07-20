//
//  FeedCell.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class FeedCell: RecipeBigCell {
    static let id = "FeedCell"

    override func setupView() {
        super.setupView()

        // need to be user not interactive to avoid saving to core data without image
        // it will be not interactive until cell is fully configured
        favoriteButton.isUserInteractionEnabled = false
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
            favoriteButton.tintColor = FeedConstants.Cell.Design.favoriteButtonTintColor

            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImageFill, for: .normal)
        } else {
            favoriteButton.setImage(FeedConstants.Cell.Image.favoriteImage, for: .normal)
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
