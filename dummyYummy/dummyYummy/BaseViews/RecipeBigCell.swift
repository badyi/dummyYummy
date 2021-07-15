//
//  RecipeBigCell.swift
//  dummyYummy
//
//  Created by badyi on 15.07.2021.
//

import UIKit

class RecipeBigCell: RoundedCollectionCellWithShadow {
    var favoriteButtonTapHandle: (() -> ())?
    var shareButtonTapHandle: (() -> ())?
    
    var imageViewConstraints: [NSLayoutConstraint] = []
    var titleLabelConstraints: [NSLayoutConstraint] = []
    var healthScoreLabelConstraints: [NSLayoutConstraint] = []
    var minutesLabelConstraints: [NSLayoutConstraint] = []
    var shareButtonConstraints: [NSLayoutConstraint] = []
    var favoriteButtonConstraints: [NSLayoutConstraint] = []
    
    var imageView: ShimmerUIImageView = {
        return UIImageViewBuilder()
            .buildWithShimmer()
    }()
    
    var titleLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .buildWithShimmer()
    }()
    
    var healthScoreLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .buildWithShimmer()
    }()
    
    var minutesLabel: ShimmerUILabel = {
        return UILabelBuilder()
            .buildWithShimmer()
    }()
    
    var shareButton: ShimmerUIButton = {
        let button = UIButtonBuilder()
            .largeConfig(true)
            .buildWithShimmer()
        return button
    }()
    
    var favoriteButton: ShimmerUIButton = {
        let button = UIButtonBuilder()
            .largeConfig(true)
            .buildWithShimmer()
        return button
    }()
    
    var isShimmerAnimatin: Bool = false
    
    func stopAnimation() {
        titleLabel.removeShimmerAnimation()
        healthScoreLabel.removeShimmerAnimation()
        minutesLabel.removeShimmerAnimation()
        
        favoriteButton.removeShimmerAnimation()
        shareButton.removeShimmerAnimation()
    }
    
    func stopImageViewAnimation() {
        imageView.removeShimmerAnimation()
    }
    
    func startAnimation() {
        imageView.startShimmerAnimation()
        titleLabel.startShimmerAnimation()
        healthScoreLabel.startShimmerAnimation()
        minutesLabel.startShimmerAnimation()

        favoriteButton.startShimmerAnimation()
        shareButton.startShimmerAnimation()
    }
}

extension RecipeBigCell {
    func setupImageViews() {
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    func setupLabels() {
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(minutesLabelConstraints)
        NSLayoutConstraint.activate(healthScoreLabelConstraints)
    }
    
    func setupButtons() {
        NSLayoutConstraint.activate(shareButtonConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
    }
}
