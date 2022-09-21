//
//  AndesMoneyAmountIcon.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 6/02/22.
//

import Foundation

/**
 Object model that contains the Currency Icon representation
 */
class AndesMoneyAmountCurrencyIcon {
    private(set) var currencyIcon: String?
    private(set) var currencyIconSize: CGFloat
    private(set) var currencyIconPadding: CGFloat

    init(currencyIcon: String?, currencyIconSize: CGFloat = 0.0, currencyIconPadding: CGFloat = 0.0) {
        self.currencyIcon = currencyIcon
        self.currencyIconSize = currencyIconSize
        self.currencyIconPadding = currencyIconPadding
    }
}
