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
        let width = size.width - (textInsets.left + textInsets.right)
        let height = size.height - (textInsets.top + textInsets.bottom)
        var size = super.sizeThatFits(CGSize(width: width, height: height))
        size.height += textInsets.top + textInsets.bottom
        return size
    }
}
