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
