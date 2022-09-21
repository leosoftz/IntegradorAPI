//
//  
//  AndesMoneyAmountComboViewConfig.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

/// used to define the ui of internal AndesMoneyAmountCombo views
internal struct AndesMoneyAmountComboViewConfig {
    var size: AndesMoneyAmountComboSize = .size24
    var moneyAmount: AndesMoneyAmount = AndesMoneyAmount()
    var discount: AndesMoneyAmountDiscount?
    var previous: AndesMoneyAmount?

    init() {}

    init(size: AndesMoneyAmountComboSize, moneyAmount: AndesMoneyAmount, discount: AndesMoneyAmountDiscount?, previous: AndesMoneyAmount?) {
        self.size = size
        self.moneyAmount = moneyAmount
        self.discount = discount
        self.previous = previous
    }
}
