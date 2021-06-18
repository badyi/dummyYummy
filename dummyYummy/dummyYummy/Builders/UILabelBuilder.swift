//
//  UILabelBuilder.swift
//  dummyYummy
//
//  Created by badyi on 14.06.2021.
//

import UIKit

final class UILabelBuilder {
    public private(set) var text: String = ""
    public private(set) var textColor: UIColor = .black
    public private(set) var translatesAutoresizingMaskIntoConstraints: Bool = false
    public private(set) var backgroundColor: UIColor = .white
    public private(set) var fontSize: Int = 17
    public private(set) var font: UIFont? = nil
}

extension UILabelBuilder {
    @discardableResult
    public func setFont(_ font: UIFont) -> UILabelBuilder {
        self.font = font
        return self
    }
    
    @discardableResult
    public func fontSize(_ size: Int) -> UILabelBuilder {
        self.fontSize = size
        return self
    }
    
    @discardableResult
    public func setText(_ text: String) -> UILabelBuilder {
        self.text = text
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> UILabelBuilder {
        textColor = color
        return self
    }

    @discardableResult
    public func translatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> UILabelBuilder {
        translatesAutoresizingMaskIntoConstraints = flag
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> UILabelBuilder {
        self.backgroundColor = color
        return self
    }
    
    public func build() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.text = text
        if let font = self.font {
            label.font = font
        }
        return label
    }
}

