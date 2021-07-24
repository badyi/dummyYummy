//
//  BaseRecipesConstants.swift
//  dummyYummy
//
//  Created by badyi on 17.07.2021.
//

import UIKit

struct BaseRecipeConstants {
    struct ViewController {
        struct Layout {
            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }

        struct Design {
            static let navigationTextColor: UIColor = Colors.wisteria
            static var backgroundColor = Colors.nero
            static var navBarBackgroundColor = Colors.black
            static var navBarBarTintColor = Colors.black
            static var navBarTintColor = Colors.wisteria
        }

        struct Image {
            static let navBarBackground = UIImage()
            static let navBarShadowImage = UIImage()
        }
    }

    struct Cell {
        struct Layout {
            /// Shadow and corner
            static let cornerRadius: CGFloat = 10
            static let shadowRadius: CGFloat = 6
            static let shadowOpacity: Float = 0.4
            static let shadowOffsetWidth: CGFloat = 0
            static let shadowOffsetHeight: CGFloat = 5
        }

        struct Design {
            static var backgroundColor = Colors.eclipse
            static var titleBackgroundColor = Colors.wisteria.withAlphaComponent(0.5)
            static var titleColor = Colors.almostPureWhite
            static var additinalTextColor = Colors.mediumPureWhite
            static var shadowColor = Colors.pureBlack
            static var buttonTintColor = Colors.veryLightGray
        }

        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }
    }

    struct BigCell {
        struct Layout {
            static let horizontalSpace: CGFloat = 5
            static let verticalSpace: CGFloat = 2
            static let bottomSpace: CGFloat = 10
            static let topSpace: CGFloat = 10
            static let leadingSpace: CGFloat = 10
            static let trailingSpace: CGFloat = 10

            static let imageHeight: CGFloat = 250
            static let healthScoreHeight: CGFloat = 20
            static let minutesHeight: CGFloat = 20
            static let minimalTitleHeight: CGFloat = 20

            static let buttonWidth: CGFloat = 45

            /// Shadow and corner
            static let cornerRadius: CGFloat = 10
            static let shadowRadius: CGFloat = 6
            static let shadowOpacity: Float = 0.4
            static let shadowOffsetWidth: CGFloat = 0
            static let shadowOffsetHeight: CGFloat = 5
        }

        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }

        struct Image {
            static let defaultCellImage = UIImage(named: "defaultFoodImage") ?? UIImage()
            static let shareImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let favoriteImage = UIImage(systemName: "suit.heart") ?? UIImage()
            static let favoriteImageFill = UIImage(systemName: "suit.heart.fill") ?? UIImage()
        }

        struct Design {
            static var backgroundColor = Colors.eclipse
            static var titleColor = Colors.almostPureWhite
            static var additinalTextColor = Colors.mediumPureWhite
            static var shadowColor = Colors.pureBlack
            static var buttonTintColor = Colors.veryLightGray
        }
    }
}
