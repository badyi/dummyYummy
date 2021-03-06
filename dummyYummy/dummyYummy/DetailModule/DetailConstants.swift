//
//  DetailConstants.swift
//  dummyYummy
//
//  Created by badyi on 07.07.2021.
//

import UIKit

struct DetailConstants {
    struct ViewController {
        struct Layout {
            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            static let headerWithTitleHeight: CGFloat = 50
            static let footerHeight: CGFloat = 10
            static let minimumLineSpacingForSection: CGFloat = 10
            static let minimumInteritemSpacingForSection: CGFloat = 0
        }

        struct Design {
            static let navigationTextColor: UIColor = Colors.wisteria
            static let backgroundColor = Colors.nero
            static let navBarBackgroundColor = Colors.black
        }
    }

    struct Header {
        struct Layout {
            static let cornerRadius: CGFloat = 10
            static let shadowRadius: CGFloat = 6
            static let shadowOpacity: Float = 0.4
            static let shadowOffsetWidth: CGFloat = 1
            static let shadowOffsetHeight: CGFloat = 2

            static let horizontalSpace: CGFloat = 10
            static let verticalSpace: CGFloat = 10
            static let spaceBetweenButtons: CGFloat = 5

            static let imageHeight: CGFloat = 250
            static let healthScoreHeight: CGFloat = 20
            static let minutesHeight: CGFloat = 20
            static let minimalTitleHeight: CGFloat = 20

            static let buttonHeight: CGFloat = 45
            static let bottomGapHeight: CGFloat = 10
        }

        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }

        struct Image {
            static let shareImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let favoriteImage = UIImage(systemName: "suit.heart") ?? UIImage()
            static let favoriteImageFill = UIImage(systemName: "suit.heart.fill") ?? UIImage()
            static let chevronRight = {
                UIImage(systemName: "chevron.right.circle")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
            }()
            static let defaultCellImage = UIImage(named: "defaultFoodImage") ?? UIImage()
            static let chevronDown = {
                UIImage(systemName: "chevron.down.circle")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
            }()
        }

        struct Design {
            static let selectedSegmentColor = Colors.wisteria
            static let backgroundColor = Colors.nero
            static let titleColor = Colors.almostPureWhite
            static let additinalTextColor = Colors.mediumPureWhite
            static let shadowColor = Colors.pureBlack
            static let buttonTintColor = Colors.veryLightGray
            static let buttonFavoriteColor = UIColor.red
            static let headerButtonTintColor = Colors.wisteria
        }
    }

    struct DetailCell {
        struct Layout {
            static let verticalSpace: CGFloat = 5
            static let horizontalSpace: CGFloat = 10
        }

        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }

        struct Design {
            static let backgroundColor = Colors.eclipse
            static let titleColor = Colors.almostPureWhite
            static let additinalTextColor = Colors.mediumPureWhite
            static let shadowColor = Colors.pureBlack
            static let buttonTintColor = Colors.veryLightGray
        }
    }
}
