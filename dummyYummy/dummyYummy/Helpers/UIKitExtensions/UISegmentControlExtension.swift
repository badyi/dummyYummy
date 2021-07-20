//
//  UISegmentControlBackgroundExtension.swift
//  dummyYummy
//
//  Created by badyi on 11.07.2021.
//

import UIKit

extension UISegmentedControl {
    func setImagesToBackground() {
        if let backgroundColor = backgroundColor {
            setBackgroundImage(imageWithColor(color: backgroundColor), for: .normal, barMetrics: .default)
        }
        if let selectedColor = selectedSegmentTintColor {
            setBackgroundImage(imageWithColor(color: selectedColor), for: .selected, barMetrics: .default)
        }
        setDividerImage(imageWithColor(color: UIColor.clear),
                        forLeftSegmentState: .normal,
                        rightSegmentState: .normal,
                        barMetrics: .default)
    }

    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
