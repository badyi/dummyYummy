//
//  ShadowCellBase.swift
//  dummyYummy
//
//  Created by badyi on 01.07.2021.
//

import UIKit

class RoundedCollectionCellWithShadow: UICollectionViewCell {
    
    var shadowColor: UIColor = .black
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 0
    var shadowOpacity: Float = 0
    var shadowOffsetWidth: CGFloat = 0
    var shadowOffsetHeight: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: FeedCellConstants.Layout.cornerRadius
        ).cgPath
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
    
    func setupShadow() {
        /// Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        /// Apply a shadow
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    }
}
