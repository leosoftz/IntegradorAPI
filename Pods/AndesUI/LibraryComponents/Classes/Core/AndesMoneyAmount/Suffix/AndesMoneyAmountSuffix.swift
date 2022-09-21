//
//  AndesMoneyAmountSuffix.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 7/02/22.
//

import Foundation

/**
 Object model that contains the Currency Icon representation
 */
class AndesMoneyAmountSuffix {
    let suffix: NSMutableAttributedString?
    let suffixSize: CGFloat
    let suffixPadding: CGFloat

    init(suffix: NSMutableAttributedString?, suffixSize: CGFloat = 0.0, suffixPadding: CGFloat = 0.0) {
        self.suffix = suffix
        self.suffixSize = suffixSize
        self.suffixPadding = suffixPadding
    }
}
