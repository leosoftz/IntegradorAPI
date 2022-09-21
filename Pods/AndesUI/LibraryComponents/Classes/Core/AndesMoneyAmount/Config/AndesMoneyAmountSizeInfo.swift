//
//  AndesMoneyAmountStyleInfo.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 28/02/22.
//

import Foundation

/// used to define the style of internal AndesMoneyAmount
internal struct AndesMoneyAmountSizeInfo {
    var labelSize: CGFloat = 0.0
    var superScriptSize: CGFloat = 0.0

    init() {}

    init(labelSize: CGFloat, superScripSize: CGFloat) {
        self.labelSize = labelSize
        self.superScriptSize = superScripSize
    }
}
