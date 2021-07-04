//
//  SearchResultConstants.swift
//  dummyYummy
//
//  Created by badyi on 01.07.2021.
//

import UIKit

struct SearchResultConstants {
    struct VC {
        struct Layout {
            static let collectionViewInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            static let minimumInteritemSpacingForSection: CGFloat = 4
            static let minimumLineSpacingForSection: CGFloat = 4
            static let cellsPerLine: CGFloat = 2
        }
        
        struct Design {
            //static let navigationTextColor: UIColor = Colors.wisteria
            static var backgroundColor = Colors.nero
            //static var navBarBackgroundColor = Colors.black
            //static var navBarBarTintColor = Colors.black
            //static var navBarTintColor = Colors.wisteria
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
}
