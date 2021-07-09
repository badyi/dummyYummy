//
//  DetailConstants.swift
//  dummyYummy
//
//  Created by badyi on 07.07.2021.
//

import UIKit

struct DetailConstants {
    struct VC {
        struct Layout {
            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            static let headerWithTitleHeight: CGFloat = 40
            static let characteristicsCellHeight: CGFloat = 40
            static let footerHeight: CGFloat = 1
            static let minimumLineSpacingForSection: CGFloat = 1
        }
        
        struct Design {
            static let navigationTextColor: UIColor = Colors.wisteria
            static var backgroundColor = Colors.nero
            static var navBarBackgroundColor = Colors.black
        }
    }
    
    struct Header {
        struct Layout {
            static let horizontalSpace: CGFloat = 10
            static let verticalSpace: CGFloat = 10
            static let spaceBetweenButtons: CGFloat = 5
            
            static let imageHeight: CGFloat = 250
            static let healthScoreHeight: CGFloat = 20
            static let minutesHeight: CGFloat = 20
            static let minimalTitleHeight: CGFloat = 20
            
            static let buttonHeight: CGFloat = 45
        }
        
        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
        }

        struct Image {
            static let defaultCellImage = UIImage(named: "defaultFoodImage") ?? UIImage()
            static let shareImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let favoriteImage = UIImage(systemName: "suit.heart") ?? UIImage()
        }
        
        struct Design {
            static var backgroundColor = Colors.eclipse
            static var titleColor = Colors.almostPureWhite
            static var additinalTextColor = Colors.mediumPureWhite
            static var shadowColor = Colors.pureBlack
            static var buttonTintColor = Colors.veryLightGray
        }
    }
    
    struct CharacteristicsCell {
        struct Layout {
        }
        
        struct Font {
            static let titleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 17) ?? UIFont()
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
