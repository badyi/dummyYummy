//
//  ShimmerProtocol.swift
//  dummyYummy
//
//  Created by badyi on 20.06.2021.
//

import UIKit

protocol ShimmerProtocol: UIView {
    var gradientLayer: CAGradientLayer { get set }
}

extension ShimmerProtocol {
    func startShimmerAnimation() {
        let gradientColorOne: CGColor = Colors.wisteria.cgColor // UIColor(white: 0.85, alpha: 1.0).cgColor
        let gradientColorTwo: CGColor = UIColor.white.cgColor // UIColor(white: 0.95, alpha: 1.0).cgColor

        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = 0.9
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animation.keyPath)

        self.layer.addSublayer(gradientLayer)
    }

    func removeShimmerAnimation() {
        gradientLayer.removeFromSuperlayer()
    }
}
