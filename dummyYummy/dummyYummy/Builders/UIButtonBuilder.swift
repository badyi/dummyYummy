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
    public private(set) var tintColor: UIColor = .systemBlue
    public private(set) var font: UIFont? = nil
}

extension UIButtonBuilder {
    @discardableResult
    public func setFont(_ font: UIFont) -> UIButtonBuilder {
        self.font = font
        return self
    }
    
    @discardableResult
    public func tintColor(_ color: UIColor) -> UIButtonBuilder {
        self.tintColor = color
        return self
    }
    
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
        return build(button: UIButton())
    }
    
    public func buildWithShimmer() -> ShimmerUIButton {
        return build(button: ShimmerUIButton())
    }
}

private extension UIButtonBuilder {
    func build<T: UIButton>(button: T) -> T {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.tintColor = tintColor
        
        if let font = font {
            button.titleLabel?.font = font
        }
        if let image = self.image {
            button.contentMode = .center
            button.setImage(image, for: .normal)
        }
        if largeConfig {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .medium)
            button.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
        }
        return button
    }
}
