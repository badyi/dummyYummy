//
//  DetailCell.swift
//  dummyYummy
//
//  Created by badyi on 08.07.2021.
//

import UIKit

final class DetailCell: RoundedCollectionCellWithShadow {
    
    static let id = "CharacteristicsCell"
    
    private var label: UILabel = {
        UILabelBuilder()
            .textColor(DetailConstants.DetailCell.Design.titleColor)
            .backgroundColor(DetailConstants.DetailCell.Design.backgroundColor)
            .setFont(DetailConstants.DetailCell.Font.titleFont)
            .build()
    }()
    
    override func setupView() {
        shadowColor = FeedConstants.Cell.Design.shadowColor
        cornerRadius = FeedConstants.Cell.Layout.cornerRadius
        shadowRadius = FeedConstants.Cell.Layout.shadowRadius
        shadowOpacity = FeedConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = FeedConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = FeedConstants.Cell.Layout.shadowOffsetHeight
        
        contentView.addSubview(label)
        contentView.backgroundColor = DetailConstants.DetailCell.Design.backgroundColor
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DetailConstants.DetailCell.Layout.verticalSpace),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DetailConstants.DetailCell.Layout.horizontalSpace),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DetailConstants.DetailCell.Layout.horizontalSpace),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DetailConstants.DetailCell.Layout.verticalSpace)
        ])
    }
}

extension DetailCell {
    func config( _ highlightText: String? = nil, with text: String) {
        var text = text
        if let highlightText = highlightText {
            text = highlightText + text
        }
        label.text = text
        label.highlight(text: highlightText, color: Colors.wisteria)
    }
    
    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        let verticalSpaces: CGFloat = DetailConstants.Header.Layout.horizontalSpace * 2
        let horizontalSpaces: CGFloat = DetailConstants.Header.Layout.verticalSpace * 2
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: DetailConstants.Header.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - verticalSpaces, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)
        let height = rect.height + horizontalSpaces
        return height
    }
}

private extension DetailCell {
    
}

#warning("remove from here")
extension UILabel {
    func highlight(text: String?, font: UIFont? = nil, color: UIColor? = nil) {
        guard let fullText = self.text, let target = text else {
            return
        }

        let attribText = NSMutableAttributedString(string: fullText)
        let range: NSRange = attribText.mutableString.range(of: target, options: .caseInsensitive)
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let font = font {
            attributes[.font] = font
        }
        if let color = color {
            attributes[.foregroundColor] = color
        }
        attribText.addAttributes(attributes, range: range)
        self.attributedText = attribText
    }
}
