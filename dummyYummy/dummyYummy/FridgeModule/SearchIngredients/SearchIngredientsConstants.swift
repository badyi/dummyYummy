//
//  SearchIngredientsConstants.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import UIKit

struct SearchIngredientsConstants {
    struct ViewController {
        struct Layout {
            static let mimimalCellHeight: CGFloat = 50
        }

        struct Design {
            static let backgroundColor = Colors.nero
        }
    }

    struct Cell {
        struct Design {
            static let backgroundColor = Colors.eclipse
            static let titleColor = Colors.almostPureWhite
            static var buttonTintColor = Colors.veryLightGray
            static let minusButtonTintColor = UIColor.red
        }

        struct Layout {
            static let verticalSpace: CGFloat = 15
            static let horizontalSpace: CGFloat = 20
            static let buttonWidth: CGFloat = 30
        }

        struct Images {
            static let plusCircle = UIImage(systemName: "plus.circle") ?? UIImage()
            static let minusCircle = UIImage(systemName: "minus.circle") ?? UIImage()
        }

        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }
    }
}
