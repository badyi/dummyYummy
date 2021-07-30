//
//  ImageViewController.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

final class GuideViewController: UIViewController {
    var imageView: UIImageView = {
        UIImageViewBuilder()
            .contentMode(.scaleAspectFit)
            .backgroundColor(Colors.pureBlack)
            .build()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension GuideViewController {
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}

extension GuideViewController {
    private func setupView() {
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
