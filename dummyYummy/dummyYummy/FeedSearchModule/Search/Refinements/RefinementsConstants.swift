//
//  RefinementsConstants.swift
//  dummyYummy
//
//  Created by badyi on 03.07.2021.
//

import UIKit

struct RefinementsConstants {
    /// For view controller
    struct ViewController {
        struct Layout {
            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            static let minimumLineSpacing: CGFloat = 15
            static let sectionFooterHeight: CGFloat = 50
            static let heightForRow: CGFloat = 50
        }

        struct Design {
            static let navBarBackgroundColor = Colors.black
            static let backgroundColor = Colors.nero
        }
    }

    struct Cell {
        struct Layout {
            static let verticalSpace: CGFloat = 10
            static let horizontalSpace: CGFloat = 10
            static let buttonWidth: CGFloat = 30
        }

        struct Design {
            static let backgroundColor = Colors.eclipse
            static let titleColor = Colors.almostPureWhite
            static let additinalTextColor = Colors.mediumPureWhite
            static let shadowColor = Colors.pureBlack
            static let buttonTintColor = Colors.wisteria
        }

        struct Image {
            static let deleteButtonImage = UIImage(systemName: "xmark") ?? UIImage()
        }
    }
}
