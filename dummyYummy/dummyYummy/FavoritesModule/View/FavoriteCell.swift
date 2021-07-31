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

    override func setupView() {
        super.setupView()
        favoriteButton.setImage(RecipeViewConstants.BigCell.Image.favoriteImageFill, for: .normal)
    }
}
