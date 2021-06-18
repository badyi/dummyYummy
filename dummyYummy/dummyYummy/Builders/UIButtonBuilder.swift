//
//  UILabelBuilder.swift
//  dummyYummy
//
//  Created by badyi on 14.06.2021.
//

import UIKit

final class UIButtonBuilder {
    public private(set) var translatesAutoresizingMaskIntoConstraints: Bool = false
    public private(set) var backgroundColor: UIColor = .white
    public private(set) var image: UIImage?
    public private(set) var largeConfig: Bool = false
}

extension UIButtonBuilder {
    @discardableResult
    public func setImage(_ image: UIImage) -> UIButtonBuilder {
        self.image = image
        return self
    }
    
    @discardableResult
    public func translatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> UIButtonBuilder {
        translatesAutoresizingMaskIntoConstraints = flag
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> UIButtonBuilder {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func largeConfig(_ flag: Bool) -> UIButtonBuilder {
        largeConfig = flag
        return self
    }
    
    public func build() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        if let image = self.image {
            button.contentMode = .center
            button.setImage(image, for: .normal)
        }
        if largeConfig {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
            button.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
        }
        return button
    }
}

