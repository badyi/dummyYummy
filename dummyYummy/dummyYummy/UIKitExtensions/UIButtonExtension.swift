//
//  UIButtonExtension.swift
//  dummyYummy
//
//  Created by badyi on 11.07.2021.
//

import UIKit

extension UIButton {
    func rightIcon(image: UIImage) {
        subviews.forEach {
            if let view = $0 as? UIImageView, view.accessibilityLabel == "rightIconItem" {
                view.removeFromSuperview()
            }
        }
        let imageView = UIImageView(image: image)
        imageView.accessibilityLabel = "rightIconItem"
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let size = CGFloat(16)

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalToConstant: size)
        ])
    }
}
