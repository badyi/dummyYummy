//
//  DetailHeader.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailHeader: UICollectionReusableView {

    let cornerRadius: CGFloat = DetailConstants.Header.Layout.cornerRadius
    let shadowRadius: CGFloat = DetailConstants.Header.Layout.shadowRadius
    let shadowOpacity: Float = DetailConstants.Header.Layout.shadowOpacity
    let shadowOffsetWidth: CGFloat = DetailConstants.Header.Layout.shadowOffsetWidth
    let shadowOffsetHeight: CGFloat = DetailConstants.Header.Layout.healthScoreHeight

    static let id = "DetailHeader"

    var handleShareButtonTap: (() -> Void)?
    var handleFavoriteButtonTap: (() -> Void)?

    var headerTapped: (() -> Void)?
    var segmentSelectedValueChanged: ((Int) -> Void)?

    var isExpanded: Bool? = nil {
        willSet {
            if newValue == true {
                headerButton.rightIcon(image: DetailConstants.Header.Image.chevronDown)
            } else if newValue == false {
                headerButton.rightIcon(image: DetailConstants.Header.Image.chevronRight)
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

    private lazy var headerButton: UIButton = {
        let button = UIButtonBuilder()
                        .backgroundColor(DetailConstants.Header.Design.backgroundColor)
                        .setFont(DetailConstants.Header.Font.titleFont)
                        .build()
        button.addTarget(self, action: #selector(headerButtonTap), for: .touchUpInside)
        button.tintColor = DetailConstants.Header.Design.headerButtonTintColor
        return button
    }()

    private var titleLabel: UILabel = {
        UILabelBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .textColor(DetailConstants.Header.Design.titleColor)
            .setFont(DetailConstants.Header.Font.titleFont)
            .build()
    }()

    private lazy var favoriteButton: ShimmerUIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .setImage(DetailConstants.Header.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .buildWithShimmer()
        button.addTarget(self, action: #selector(favoriteDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: ShimmerUIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .setImage(DetailConstants.Header.Image.shareImage)
            .buildWithShimmer()
        button.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        return button
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
        shareButton.removeFromSuperview()
        favoriteButton.removeFromSuperview()
        headerButton.removeFromSuperview()
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
            favoriteButton.tintColor = DetailConstants.Header.Design.buttonFavoriteColor
            favoriteButton.setImage(DetailConstants.Header.Image.favoriteImageFill, for: .normal)
        } else {
            favoriteButton.tintColor = DetailConstants.Header.Design.buttonTintColor
            favoriteButton.setImage(DetailConstants.Header.Image.favoriteImage, for: .normal)
        }

        if recipe.imageURL == nil {
            imageView.image = DetailConstants.Header.Image.defaultCellImage
            return
        }

        guard let imageData = recipe.imageData,
              let image = UIImage(data: imageData) else {
            imageView.image = DetailConstants.Header.Image.defaultCellImage
            return
        }
        imageView.image = image
    }

    func configViewWith(title: String) {
        setupWithTitle()
        headerButton.setTitle(title, for: .normal)
    }

    func configWithSegment(_ currentSelected: Int) {
        segmentControll.selectedSegmentIndex = currentSelected
        setupWithSegment()
    }
}

extension DetailHeader {
    @objc
    private func segmentChange(sender: UISegmentedControl) {
        segmentSelectedValueChanged?(sender.selectedSegmentIndex)
    }

    @objc
    private func favoriteDidTap() {
        handleFavoriteButtonTap?()
    }

    @objc
    private func shareDidTap() {
        handleShareButtonTap?()
    }

    private func setupView() {
        addSubview(contentView)

        setupContentView()

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(shareButton)
        contentView.addSubview(favoriteButton)

        setupImageView()
        setupTitleLabel()
        setupButtons()
    }

    private func setupWithTitle() {
        addSubview(contentView)
        contentView.addSubview(headerButton)
        setupContentView()

        NSLayoutConstraint.activate([
            headerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupWithSegment() {
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

    @objc
    private func headerButtonTap() {
        headerTapped?()
    }

    private func setupContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                constant: -DetailConstants.Header.Layout.bottomGapHeight)
        ])
    }

    private func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.imageHeight)
        ])
    }

    private func setupTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor,
                                            constant: DetailConstants.Header.Layout.verticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor,
                                                constant: DetailConstants.Header.Layout.horizontalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -DetailConstants.Header.Layout.horizontalSpace)
        ])
    }

    private func setupButtons() {
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                          constant: DetailConstants.Header.Layout.verticalSpace),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                               constant: -DetailConstants.Header.Layout.horizontalSpace),
            favoriteButton.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.buttonHeight),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            shareButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.buttonHeight),
            shareButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor,
                                            constant: -DetailConstants.Header.Layout.spaceBetweenButtons)
        ])
    }

    private func addArrowImageToButton(button: UIButton, arrowImage: UIImage) {
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
