//
//  UILabelWithInsets.swift
//  dummyYummy
//
//  Created by badyi on 11.07.2021.
//

import UIKit

final class UILabelWithInsets: UILabel {
    var textInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var s = super.sizeThatFits(CGSize(width: size.width - (textInsets.left + textInsets.right), height: size.height - (textInsets.top + textInsets.bottom)))
        s.height += textInsets.top + textInsets.bottom
        return s
    }
}
