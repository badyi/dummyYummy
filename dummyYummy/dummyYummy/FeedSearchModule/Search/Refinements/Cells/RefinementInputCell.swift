//
//  RefinementCell.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import UIKit

final class RefinementInputCell: BaseInputTableViewCell {
    static let id = "RefinementCell"
    var deleteTapped: ((IndexPath?) -> ())?
    var indexPath: IndexPath?
    
    private let label: UILabel = {
        return UILabelBuilder()
            .backgroundColor(.orange)
            .build()
    }()
    
    private let inputLabel: UILabel = {
        return UILabelBuilder()
            .backgroundColor(.red)
            .build()
    }()
    
    private lazy var activateButton: UIButton = {
        let button = UIButtonBuilder()
            .backgroundColor(.cyan)
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
            return
        }
        inputLabel.text = ""
    }
}

extension RefinementInputCell {
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func configCell(with text: String, _ isActive: Bool) {
        label.text = text
    }
}

private extension RefinementInputCell {
    @objc func deleteButtonTapped() {
        inputLabel.text = ""
        deleteTapped?(indexPath)
    }
    
    func setupView() {
        contentView.backgroundColor = .yellow
        contentView.addSubview(label)
        contentView.addSubview(activateButton)
        setupTextFiled()
        contentView.addSubview(inputLabel)
        label.backgroundColor = .black
        label.textColor = .white
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            inputLabel.topAnchor.constraint(equalTo: label.topAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: activateButton.safeAreaLayoutGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            activateButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            activateButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            activateButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            activateButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
