//
//  
//  AndesMoneyAmountViewConfig.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

/// used to define the ui of internal AndesMoneyAmountPrice views
internal struct AndesMoneyAmountViewConfig {
    let type: AndesMoneyAmountType
    let decimalStyle: AndesMoneyAmountDecimalStyle
    let decimalSeparator: String
    let amount: String
    let sizes: AndesMoneyAmountSizeInfo

    init(type: AndesMoneyAmountType = .positive,
         decimalStyle: AndesMoneyAmountDecimalStyle = .normal,
         decimalSeparator: String = ".",
         amount: String = "",
         sizes: AndesMoneyAmountSizeInfo = AndesMoneyAmountSizeInfo()) {
        self.type = type
        self.decimalStyle = decimalStyle
        self.decimalSeparator = decimalSeparator
        self.amount = amount
        self.sizes = sizes
    }
}
