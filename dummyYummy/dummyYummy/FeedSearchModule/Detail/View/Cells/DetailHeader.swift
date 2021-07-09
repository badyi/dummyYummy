//
//  DetailHeader.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailHeader: UICollectionReusableView {
    
    static let id = "DetailHeader"
    
    var headerTapped: (() -> ())?
    
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
        return UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .setImage(DetailConstants.Header.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .buildWithShimmer()
    }()
    
    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(DetailConstants.Header.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(DetailConstants.Header.Design.buttonTintColor)
            .setImage(DetailConstants.Header.Image.shareImage)
            .buildWithShimmer()
    }()
    
    private var segmentControll: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .red
        return segment
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        let imageHeight: CGFloat = DetailConstants.Header.Layout.imageHeight
        let buttonHeight: CGFloat = DetailConstants.Header.Layout.buttonHeight
        let verticalSpaces: CGFloat = DetailConstants.Header.Layout.horizontalSpace * 2
        let horizontalSpaces: CGFloat = DetailConstants.Header.Layout.verticalSpace * 3
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: DetailConstants.Header.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - verticalSpaces, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)
        let height = rect.height + imageHeight + horizontalSpaces + buttonHeight
        return height
    }
    
    func configView(with recipe: FeedRecipe) {
        setupView()
        titleLabel.text = recipe.title
        
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
    
    func configWithSegment() {
        setupWithSegment()
    }
}

private extension DetailHeader {
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
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
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
            titleLabel.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: DetailConstants.Header.Layout.verticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: DetailConstants.Header.Layout.horizontalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor, constant: -DetailConstants.Header.Layout.horizontalSpace)
        ])
    }
    
    func setupButtons() {
        
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DetailConstants.Header.Layout.verticalSpace),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DetailConstants.Header.Layout.horizontalSpace),
            favorite.heightAnchor.constraint(equalToConstant: DetailConstants.Header.Layout.buttonHeight),
            favorite.widthAnchor.constraint(equalTo: favorite.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: favorite.topAnchor),
            share.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            share.heightAnchor.constraint(equalTo: share.widthAnchor),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor, constant: -DetailConstants.Header.Layout.spaceBetweenButtons)
        ])
    }
    
}
