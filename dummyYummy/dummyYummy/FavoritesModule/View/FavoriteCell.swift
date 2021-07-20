//
//  FavoriteCell.swift
//  dummyYummy
//
//  Created by badyi on 15.07.2021.
//

import UIKit

final class FavoriteCell: RecipeBigCell {
    static let id = "FavoriteCell"

    // MARK: - View lifecycle methods
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        minutesLabel.text = ""
        healthScoreLabel.text = ""
    }

    override func setupView() {
        super.setupView()
        favoriteButton.setImage(BaseRecipeConstants.Cell.Image.favoriteImageFill, for: .normal)
    }
}

extension FavoriteCell {
    func configView(with recipe: Recipe) {
        titleLabel.text = recipe.title
        favoriteButton.tintColor = .red
        if let score = recipe.healthScore, let time = recipe.readyInMinutes {
            healthScoreLabel.text = "Health score: \(score)"
            minutesLabel.text = "Cooking minutes: \(time)"
        }

        // set default image if recipe dont have image url and remove shimmer animation
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
}
