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
            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            static let headerWithTitleHeight: CGFloat = 45
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
            static let defaultCellImage = UIImage(named: "defaultFoodImage") ?? UIImage()
            static let shareImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let favoriteImage = UIImage(systemName: "suit.heart") ?? UIImage()
        }
        
        struct Design {
            static let selectedSegmentColor = Colors.wisteria
            static let backgroundColor = Colors.nero
            static let titleColor = Colors.almostPureWhite
            static let additinalTextColor = Colors.mediumPureWhite
            static let shadowColor = Colors.pureBlack
            static let buttonTintColor = Colors.veryLightGray
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
