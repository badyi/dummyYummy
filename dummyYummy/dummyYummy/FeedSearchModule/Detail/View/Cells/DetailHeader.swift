//
//  DetailHeader.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailHeader: UICollectionReusableView {
    
    static let id = "DetailHeader"
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageView: ShimmerUIImageView = {
        UIImageViewBuilder()
            .backgroundColor(.red)
            .buildWithShimmer()
    }()
    
    private var titleLabel: UILabel = {
        UILabelBuilder()
            .backgroundColor(.black)
            .textColor(.white)
            .build()
    }()
    
    private lazy var favorite: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .setImage(FeedConstants.Cell.Image.favoriteImage)
            .largeConfig(true)
            .tintColor(FeedConstants.Cell.Design.buttonTintColor)
            .buildWithShimmer()
    }()
    
    private lazy var share: ShimmerUIButton = {
        return UIButtonBuilder()
            .backgroundColor(FeedConstants.Cell.Design.backgroundColor)
            .largeConfig(true)
            .tintColor(FeedConstants.Cell.Design.buttonTintColor)
            .setImage(FeedConstants.Cell.Image.shareImage)
            .buildWithShimmer()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailHeader {
    static func heightForCell(with title: String, width: CGFloat) -> CGFloat {
        let imageHeight: CGFloat = 250
        let buttonHeight: CGFloat = 45
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FeedConstants.Cell.Font.titleFont])
        let rect = attributedString.boundingRect(with:
                CGSize(width: width - 20, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin, context: nil)
        let height = rect.height + imageHeight + 30 + buttonHeight
        return height
    }
    
    func configView(with recipe: FeedRecipe) {
        titleLabel.text = recipe.title
        
        guard let imageData = recipe.imageData else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        imageView.image = image
    }
}

private extension DetailHeader {
    func setupView() {
        addSubview(contentView)
        contentView.backgroundColor = .red
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(share)
        contentView.addSubview(favorite)
        
        setupImageView()
        setupTitleLabel()
        setupButtons()
    }
    
    func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    func setupButtons() {
        
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            favorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FeedConstants.Cell.Layout.trailingSpace),
            favorite.widthAnchor.constraint(equalToConstant: 45),
            favorite.heightAnchor.constraint(equalTo: favorite.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            share.topAnchor.constraint(equalTo: favorite.topAnchor),
            share.widthAnchor.constraint(equalToConstant: FeedConstants.Cell.Layout.buttonWidth),
            share.heightAnchor.constraint(equalTo: share.widthAnchor),
            share.trailingAnchor.constraint(equalTo: favorite.leadingAnchor, constant: -5)
        ])
    }
    
}
