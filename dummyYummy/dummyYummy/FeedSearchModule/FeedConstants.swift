//
//  FeedConstants.swift
//  dummyYummy
//
//  Created by badyi on 04.07.2021.
//

import UIKit

struct FeedConstants {
    struct ViewController {
        struct Layout {
            static let collectionfInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            static let emptyCellsCount: Int = 10
            static let minimumLineSpacing: CGFloat = 15
        }

        struct Design {
            static let navigationTextColor: UIColor = Colors.wisteria
            static let backgroundColor = Colors.nero
            static let navBarBackgroundColor = Colors.black
            static let navBarBarTintColor = Colors.black
            static let navBarTintColor = Colors.wisteria
            static let searchTextColor = Colors.white
        }

        struct Image {
            static let navBarBackground = UIImage()
            static let navBarShadowImage = UIImage()
        }
    }

    struct Cell {
        struct Image {
            static let defaultCellImage = UIImage(named: "defaultFoodImage") ?? UIImage()
            static let shareImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let favoriteImage = UIImage(systemName: "suit.heart") ?? UIImage()
            static let favoriteImageFill = UIImage(systemName: "suit.heart.fill") ?? UIImage()
        }

        struct Design {
            static let favoriteButtonTintColor = UIColor.red
        }
    }
}
