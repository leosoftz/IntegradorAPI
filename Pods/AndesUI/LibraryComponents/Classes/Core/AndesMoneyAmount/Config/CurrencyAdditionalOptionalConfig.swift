//
//  AndesMoneyAmountViewHelperConfig.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 2/03/22.
//

import Foundation

/// used to define the ui of internal AndesMoneyAmountPrice helper views
internal struct CurrencyAdditionalOptionalConfig {
    let currencyIcon: AndesMoneyAmountCurrencyIcon?
    let showIcon: Bool
    let suffix: AndesMoneyAmountSuffix?
    let textColor: UIColor?
    let semiBold: Bool

    init(currencyIcon: AndesMoneyAmountCurrencyIcon? = nil,
         showIcon: Bool = false,
         suffix: AndesMoneyAmountSuffix? = nil,
         textColor: UIColor? = nil,
         semiBold: Bool = false) {
        self.currencyIcon = currencyIcon
        self.showIcon = showIcon
        self.suffix = suffix
        self.textColor = textColor
        self.semiBold = semiBold
    }
}
