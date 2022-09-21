//
//  AndesAutosuggestFloatingMenuDirectionPolicy.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 08/06/2021.
//

import UIKit

class AndesAutosuggestFloatingMenuLocationPolicy {
    static let minHeight: CGFloat = 100

    internal static func preferedLocation(targetView: UIView, superView: UIView, availableFrame: CGRect) -> AndesAutosuggestFloatingMenuLocation {
        let targetViewConvertedRect = superView.convert(targetView.frame, from: targetView)
        let upAvailableHeight = targetViewConvertedRect.minY - availableFrame.minY
        let bottomAvailableHeight = availableFrame.maxY - targetViewConvertedRect.maxY

        if upAvailableHeight > bottomAvailableHeight {
            return AndesAutosuggestFloatingMenuLocation(height: upAvailableHeight, direction: .up)
        } else {
            return AndesAutosuggestFloatingMenuLocation(height: bottomAvailableHeight, direction: .down)
        }
    }
}
