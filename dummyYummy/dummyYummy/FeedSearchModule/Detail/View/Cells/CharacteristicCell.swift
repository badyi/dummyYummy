//
//  CharacteristicCell.swift
//  dummyYummy
//
//  Created by badyi on 08.07.2021.
//

import UIKit

final class CharacteristicsCell: UICollectionViewCell {
    
    static let id = "CharacteristicsCell"
    
    private var label: UILabel = {
        UILabelBuilder()
            .textColor(DetailConstants.CharacteristicsCell.Design.additinalTextColor)
            .backgroundColor(DetailConstants.CharacteristicsCell.Design.backgroundColor)
            .setFont(DetailConstants.CharacteristicsCell.Font.titleFont)
            .build()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacteristicsCell {
    func config(with text: String) {
        label.text = text
    }
}

private extension CharacteristicsCell {
    func setupView() {
        contentView.addSubview(label)
        contentView.backgroundColor = DetailConstants.CharacteristicsCell.Design.backgroundColor
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
