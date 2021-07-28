//
//  FridgeConstants.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import UIKit

struct FridgeConstants {
    struct ViewController {
        struct Layout {
            static let searchButtonHeight: CGFloat = 50
        }

        struct Design {
            static var backgroundColor = Colors.nero
            static let navigationTextColor = Colors.wisteria
            static var navBarBackgroundColor = Colors.black
            static var navBarBarTintColor = Colors.black
            static var navBarTintColor = Colors.wisteria
            static var searchTextColor = Colors.white
        }

        struct Image {
            static let navBarBackground = UIImage()
            static let navBarShadowImage = UIImage()
        }

        struct Font {
            static let navBarTitleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 19) ?? UIFont()
        }
    }

//    struct ViewController {
//        struct Layout {
//            static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//            static let emptyCellsCount: Int = 10
//            static let minimumLineSpacing: CGFloat = 15
//        }
//
//        struct Design {
//            static var backgroundColor = Colors.nero
//            static var navBarBarTintColor = Colors.black
//            static var navBarTintColor = Colors.wisteria
//        }
//
//        struct Image {
//            static let navBarBackground = UIImage()
//            static let navBarShadowImage = UIImage()
//        }
//    }
}
