//
//  IngredinentsCell.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import UIKit

final class IngredinentsCell: UITableViewCell {

    static let id = "IngredientsCell"

    var choseButtonTapDelegate: (() -> Void)?

    private let label: UILabel = {
        UILabelBuilder()
            .backgroundColor(SearchIngredientsConstants.Cell.Design.backgroundColor)
            .textColor(SearchIngredientsConstants.Cell.Design.titleColor)
            .build()
    }()

    private lazy var choseButton: UIButton = {
        let button = UIButtonBuilder()
                        .backgroundColor(SearchIngredientsConstants.Cell.Design.backgroundColor)
                        .tintColor(SearchIngredientsConstants.Cell.Design.buttonTintColor)
                        .largeConfig(true)
                        .build()
        button.addTarget(self, action: #selector(choseButtonTap), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        choseButton.tintColor = SearchIngredientsConstants.Cell.Design.buttonTintColor
    }

    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        /// insets from left and right edges
        let layoutConstants = RefinementsConstants.Cell.Layout.self
        let horizontalInsets = (layoutConstants.horizontalSpace * 2)

        let attributedString = NSAttributedString(string: title,
                                                  attributes: [NSAttributedString.Key.font:
                                                                BaseRecipeConstants.Cell.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - horizontalInsets, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)

        /// The computed height needed for the titleLabel
        var height = rect.height +
            (layoutConstants.verticalSpace * 2)

        /// In case  title is empty, we set the default size
        if title == "" {
            height = 0
        }
        return height
    }
}

extension IngredinentsCell {
    func config(with text: String, _ isChosen: Bool) {
        label.text = text
        if isChosen {
            choseButton.setImage(SearchIngredientsConstants.Cell.Images.minusCircle, for: .normal)
            choseButton.tintColor = SearchIngredientsConstants.Cell.Design.minusButtonTintColor
            return
        }
        choseButton.setImage(SearchIngredientsConstants.Cell.Images.plusCircle, for: .normal)
    }
}

private extension IngredinentsCell {
    @objc
    func choseButtonTap() {
        choseButtonTapDelegate?()
    }

    func setupView() {
        contentView.backgroundColor = SearchIngredientsConstants.Cell.Design.backgroundColor
        contentView.addSubview(label)
        contentView.addSubview(choseButton)
        label.baselineAdjustment = .alignCenters
        setupLabel()
        setupChoseButton()
    }

    func setupLabel() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                       constant: SearchIngredientsConstants.Cell.Layout.verticalSpace),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                           constant: SearchIngredientsConstants.Cell.Layout.horizontalSpace),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -SearchIngredientsConstants.Cell.Layout.verticalSpace),
            label.trailingAnchor.constraint(equalTo: choseButton.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    func setupChoseButton() {
        NSLayoutConstraint.activate([
            choseButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                              constant: SearchIngredientsConstants.Cell.Layout.verticalSpace),
            choseButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -SearchIngredientsConstants.Cell.Layout.horizontalSpace),
            choseButton.widthAnchor.constraint(equalToConstant: SearchIngredientsConstants.Cell.Layout.buttonWidth),
            choseButton.heightAnchor.constraint(equalTo: choseButton.widthAnchor)
        ])
    }
}
