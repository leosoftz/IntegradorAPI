//
//  AndesModalCustomViewSize.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 25/07/22.
//

import Foundation

/// Used to define the style of an AndesModal
@objc
public enum AndesModalCustomViewSize: Int {
    /// Use the max space available
    case maxHeight
    /// Not allowed for modal card
    /// in card mode, the custom view needs to provide the height of the card
    case intrinsic
}
