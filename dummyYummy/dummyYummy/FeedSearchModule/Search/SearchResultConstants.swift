//
//  SearchResultConstants.swift
//  dummyYummy
//
//  Created by badyi on 01.07.2021.
//

import UIKit

struct SearchResultConstants {
    struct ViewController {
        struct Layout {
            static let collectionViewInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            static let minimumInteritemSpacingForSection: CGFloat = 4
            static let minimumLineSpacingForSection: CGFloat = 4
            static let cellsPerLine: CGFloat = 2
        }

        struct Design {
            static var activityIndicatorColor = Colors.wisteria
            static var backgroundColor = Colors.nero
        }
    }
}
