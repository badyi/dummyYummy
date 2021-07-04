//
//  RefinementCell.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import UIKit

final class RefinementCell: BaseInputTableViewCell {
    static let id = "RefinementCell"
    var deleteTapped: ((IndexPath?) -> ())?
    var indexPath: IndexPath?
    
    private let label: UILabel = {
        return UILabelBuilder()
            .backgroundColor(RefinementsConstants.Cell.Design.backgroundColor)
            .textColor(RefinementsConstants.Cell.Design.titleColor)
            .build()
    }()
    
    private let inputLabel: UILabel = {
        return UILabelBuilder()
            .backgroundColor(RefinementsConstants.Cell.Design.backgroundColor)
            .textColor(RefinementsConstants.Cell.Design.titleColor)
            .build()
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(RefinementsConstants.Cell.Design.backgroundColor)
            .setImage(RefinementsConstants.Cell.Image.deleteButtonImage)
            .tintColor(RefinementsConstants.Cell.Design.buttonTintColor)
            .build()
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View lifecycle methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(using data: Int) {
        super.update(using: data)
        if data > 0 {
            inputLabel.text = " \(data)"
            deleteButton.isHidden = false
            return
        }
        inputLabel.text = ""
        deleteButton.isHidden = true
    }
}

extension RefinementCell {
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func configCell(with text: String, _ isActive: Bool) {
        label.text = text
        deleteButton.isHidden = !isActive
    }
    
    func configInput(with text: String) {
        inputLabel.text = text
    }
}

private extension RefinementCell {
    @objc func deleteButtonTapped() {
        inputLabel.text = ""
        deleteButton.isHidden = true
        deleteTapped?(indexPath)
    }
    
    func setupView() {
        contentView.backgroundColor = RefinementsConstants.Cell.Design.backgroundColor
        contentView.addSubview(label)
        contentView.addSubview(deleteButton)
        contentView.addSubview(inputLabel)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: RefinementsConstants.Cell.Layout.verticalSpace),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: RefinementsConstants.Cell.Layout.horizontalSpace),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -RefinementsConstants.Cell.Layout.horizontalSpace)
        ])
        
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            inputLabel.topAnchor.constraint(equalTo: label.topAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: deleteButton.safeAreaLayoutGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: RefinementsConstants.Cell.Layout.verticalSpace),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -RefinementsConstants.Cell.Layout.horizontalSpace),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -RefinementsConstants.Cell.Layout.horizontalSpace),
            deleteButton.widthAnchor.constraint(equalToConstant: RefinementsConstants.Cell.Layout.buttonWidth)
        ])
    }
}
