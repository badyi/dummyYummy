//
//  IngredientsCellConstants.swift
//  dummyYummy
//
//  Created by badyi on 25.07.2021.
//

import UIKit

struct IngredientsCellConstants {

    struct Layout {
        static let verticalSpace: CGFloat = 10
        static let horizontalSpace: CGFloat = 15
        static let buttonWidth: CGFloat = 30
    }

    struct Design {
        static let backgroundColor = Colors.nero
        static let titleColor = Colors.almostPureWhite
        static let additinalTextColor = Colors.mediumPureWhite
        static let shadowColor = Colors.pureBlack
        static let buttonTintColor = Colors.wisteria
        static let minusButtonTintColor = UIColor.red
    }

    struct Images {
        static let deleteButtonImage = UIImage(systemName: "xmark") ?? UIImage()
        static let plusCircle = UIImage(systemName: "plus.circle") ?? UIImage()
        static let minusCircle = UIImage(systemName: "minus.circle") ?? UIImage()
    }

    struct Font {
        static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 19) ?? UIFont()
    }
}
