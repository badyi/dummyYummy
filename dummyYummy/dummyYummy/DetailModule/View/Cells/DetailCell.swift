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
        super.setupView()
        shadowColor = BaseRecipeConstants.Cell.Design.shadowColor
        cornerRadius = BaseRecipeConstants.Cell.Layout.cornerRadius
        shadowRadius = BaseRecipeConstants.Cell.Layout.shadowRadius
        shadowOpacity = BaseRecipeConstants.Cell.Layout.shadowOpacity
        shadowOffsetWidth = BaseRecipeConstants.Cell.Layout.shadowOffsetWidth
        shadowOffsetHeight = BaseRecipeConstants.Cell.Layout.shadowOffsetHeight
        
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
