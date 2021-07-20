//
//  DetailHeader.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailHeader: UICollectionReusableView {

    static let id = "DetailHeader"

    var handleShareButtonTap: (() -> Void)?
    var handleFavoriteButtonTap: (() -> Void)?

    var headerTapped: (() -> Void)?
    var segmentSelectedValueChanged: ((Int) -> Void)?
    var isExpanded: Bool? = nil {
        willSet {
            if newValue == true {
                button.rightIcon(image: DetailConstants.Header.Image.chevronDown)
            } else if newValue == false {
                button.rightIcon(image: DetailConstants.Header.Image.chevronRight)
            }
        }
    }

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DetailConstants.Header.Design.backgroundColor
        return view
    }()

    private var imageView: ShimmerUIImageView = {
        UIImageViewBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .buildWithShimmer()
    }()

    private lazy var button: UIButton = {
        let button = UIButtonBuilder()
                        .backgroundColor(DetailConstants.Header.Design.backgroundColor)
                        .setFont(DetailConstants.Header.Font.titleFont)
                        .build()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.tintColor = Colors.wisteria
        return button
    }()

    private var titleLabel: UILabel = {
        UILabelBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .textColor(DetailConstants.Header.Design.titleColor)
            .setFont(DetailConstants.Header.Font.titleFont)
            .build()
    }()

    private lazy var favorite: ShimmerUIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .setImage(DetailConstants.Header.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .buildWithShimmer()
        button.addTarget(self, action: #selector(favoriteDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .setImage(DetailConstants.Header.Image.shareImage)
            .buildWithShimmer()
    }()

    var segmentItems = ["Ingredients", "Instructions"]
    var currentSelectedSegment: Int = 0

    private lazy var segmentControll: UISegmentedControl = {
        let segment = UISegmentedControl(items: segmentItems)
        segment.translatesAutoresizingMaskIntoConstraints = false

        segment.backgroundColor = Colors.nero
        segment.selectedSegmentTintColor = DetailConstants.Header.Design.selectedSegmentColor
        segment.setImagesToBackground()

        let keyFont = NSAttributedString.Key.font
        let keyForegroundColor = NSAttributedString.Key.foregroundColor
        let titleFont = DetailConstants.Header.Font.titleFont
        let titleColor = DetailConstants.Header.Design.titleColor
        segment.setTitleTextAttributes([keyFont: titleFont, keyForegroundColor: titleColor], for: .normal)
        segment.selectedSegmentIndex = currentSelectedSegment
        segment.addTarget(self, action: #selector(segmentChange(sender:)), for: .valueChanged)
        return segment
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let cornerRadius: CGFloat = 10
    let shadowRadius: CGFloat = 6
    let shadowOpacity: Float = 0.4
    let shadowOffsetWidth: CGFloat = 0
    let shadowOffsetHeight: CGFloat = 2

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.shadowPath = UIBezierPath(
            roundedRect: contentView.bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }

    func setupShadow() {
        // Apply a shadow and round
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        contentView.layer.shadowRadius = shadowRadius
        contentView.layer.shadowOpacity = shadowOpacity
        contentView.layer.shadowColor = UIColor.black.cgColor

        contentView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        share.removeFromSuperview()
        favorite.removeFromSuperview()
        button.removeFromSuperview()
        segmentControll.removeFromSuperview()
    }
}

extension DetailHeader {
    static func heightForHeaderCellWithImage(with title: String, width: CGFloat) -> CGFloat {
        let imageHeight: CGFloat = DetailConstants.Header.Layout.imageHeight
        let buttonHeight: CGFloat = DetailConstants.Header.Layout.buttonHeight
        let verticalSpaces: CGFloat = DetailConstants.Header.Layout.horizontalSpace * 2
        let horizontalSpaces: CGFloat = DetailConstants.Header.Layout.verticalSpace * 3

        let keyFont = NSAttributedString.Key.font
        let titleFont = DetailConstants.Header.Font.titleFont

        let attributedString = NSAttributedString(string: title, attributes: [keyFont: titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - verticalSpaces, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)

        let bottomGapHeight = DetailConstants.Header.Layout.bottomGapHeight
        let height = rect.height + imageHeight + horizontalSpaces + buttonHeight + bottomGapHeight

        return height
    }

    func configView(with recipe: Recipe) {
        setupView()

        titleLabel.text = recipe.title
        if recipe.isFavorite {
            favorite.tintColor = DetailConstants.Header.Design.buttonFavoriteColor
            favorite.setImage(DetailConstants.Header.Image.favoriteImageFill, for: .normal)
        } else {
            favorite.tintColor = DetailConstants.Header.Design.buttonTintColor
            favorite.setImage(DetailConstants.Header.Image.favoriteImage, for: .normal)
        }

        guard let imageData = recipe.imageData else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        imageView.image = image
    }

    func configViewWith(title: String) {
        setupWithTitle()
        button.setTitle(title, for: .normal)
    }

    func configWithSegment(_ currentSelected: Int) {
        segmentControll.selectedSegmentIndex = currentSelected
        setupWithSegment()
    }
}

private extension DetailHeader {
    @objc func segmentChange(sender: UISegmentedControl) {
        segmentSelectedValueChanged?(sender.selectedSegmentIndex)
    }

    @objc func favoriteDidTap() {
        handleFavoriteButtonTap?()
    }

    @objc func shareDidTap() {
        handleShareButtonTap?()
    }

    func setupView() {
        addSubview(contentView)

        setupContentView()

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(share)
        contentView.addSubview(favorite)

        setupImageView()
        setupTitleLabel()
        setupButtons()
    }

    func setupWithTitle() {
        addSubview(contentView)
        contentView.addSubview(button)
        setupContentView()

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setupWithSegment() {
        addSubview(contentView)
        contentView.addSubview(segmentControll)
        setupContentView()
        NSLayoutConstraint.activate([
            segmentControll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            segmentControll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            segmentControll.topAnchor.constraint(equalTo: contentView.topAnchor),
            segmentControll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc func tap() {
        headerTapped?()
    }

    func setupContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                constant: -DetailConstants.Header.Layout.bottomGapHeight)
        ])
    }

    func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.imageHeight)
        ])
    }

    func setupTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor,
                                            constant: DetailConstants.Header.Layout.verticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor,
                                                constant: DetailConstants.Header.Layout.horizontalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -DetailConstants.Header.Layout.horizontalSpace)
        ])
    }

    func setupButtons() {
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                          constant: DetailConstants.Header.Layout.verticalSpace),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                               constant: -DetailConstants.Header.Layout.horizontalSpace),
            favorite.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.buttonHeight),
            favorite.widthAnchor.constraint(equalTo: favorite.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: favorite.topAnchor),
            share.widthAnchor.constraint(equalTo: share.widthAnchor),
            share.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.buttonHeight),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor,
                                            constant: -DetailConstants.Header.Layout.spaceBetweenButtons)
        ])
    }

    func addArrowImageToButton(button: UIButton, arrowImage: UIImage) {
        let btnSize: CGFloat = 32
        let imageView = UIImageView(image: arrowImage)
        let btnFrame = button.frame
        imageView.frame = CGRect(x: btnFrame.width - btnSize - 8,
                                 y: btnFrame.height / 2 - btnSize / 2,
                                 width: btnSize,
                                 height: btnSize)
        button.addSubview(imageView)
        // Imageview on Top of View
        button.bringSubviewToFront(imageView)
    }
}
