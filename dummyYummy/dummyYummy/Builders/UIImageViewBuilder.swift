//
//  UIImageViewBuilder.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

final class UIImageViewBuilder {
    public private(set) var translatesAutoresizingMaskIntoConstraints: Bool = false
    public private(set) var backgroundColor: UIColor = .black
    public private(set) var clipToBounds: Bool = true
    public private(set) var contentMode: UIView.ContentMode = .scaleAspectFill
    public private(set) var cornerRadius: CGFloat = 0
}

extension UIImageViewBuilder {
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> UIImageViewBuilder {
        cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func translatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> UIImageViewBuilder {
        translatesAutoresizingMaskIntoConstraints = flag
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> UIImageViewBuilder {
        backgroundColor = color
        return self
    }

    public func build() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        imageView.backgroundColor = backgroundColor
        imageView.clipsToBounds = clipToBounds
        imageView.contentMode = contentMode
        imageView.layer.cornerRadius = cornerRadius
        return imageView
    }
}
