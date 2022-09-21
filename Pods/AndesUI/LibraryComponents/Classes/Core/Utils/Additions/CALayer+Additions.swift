//
//  CALayer+Additions.swift
//  AndesUI
//
//  Created by Robert Bevilacqua on 07/05/2021.
//

import UIKit

extension CALayer {
    func roundContentView(with radius: CGFloat, isMaskToBounds: Bool) {
        self.cornerRadius = radius
        self.masksToBounds = isMaskToBounds
    }

    func applyShadow(with shadowRadius: CGFloat, shadowOpacity: Float, isMaskToBounds: Bool, shadowOffSet: CGSize? = CGSize(width: 5.0, height: 5.0), shadowColor: CGColor? = UIColor.black.cgColor, shadowPath: CGPath? = nil) {
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.masksToBounds = isMaskToBounds
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffSet!
        self.shadowPath = shadowPath
    }

    func setBorder(color: CGColor, width: CGFloat) {
        self.borderColor = color
        self.borderWidth = width
    }
}
