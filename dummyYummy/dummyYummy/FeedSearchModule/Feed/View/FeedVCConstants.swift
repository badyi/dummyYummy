//
//  FeedViewControllerConstants.swift
//  dummyYummy
//
//  Created by badyi on 26.06.2021.
//

import UIKit

final class FeedVCConstants {
    struct Layout {
        static let collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let emptyCellsCount: Int = 10
        static let minimumLineSpacing: CGFloat = 15
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
