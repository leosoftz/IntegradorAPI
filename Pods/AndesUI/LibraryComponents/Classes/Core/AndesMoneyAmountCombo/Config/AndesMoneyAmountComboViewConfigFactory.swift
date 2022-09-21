//
//  
//  AndesMoneyAmountComboViewConfigFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

internal class AndesMoneyAmountComboViewConfigFactory {
    static func provideInternalConfig(size: AndesMoneyAmountComboSize, price: Double, discount: Int, previousPricePrice: Double?, currency: AndesMoneyAmountCurrency) -> AndesMoneyAmountComboViewConfig {
        var andesMoneyAmountDiscount: AndesMoneyAmountDiscount?
        var andesMoneyAmountPrevious: AndesMoneyAmount?

        if discount != 0 {
            andesMoneyAmountDiscount = AndesMoneyAmountDiscount(discountValue: discount, size: size == .size24 ? .size14 : .size18)
        }

        if let previousPricePrice = previousPricePrice {
            andesMoneyAmountPrevious = AndesMoneyAmount(type: .previous, size: size == .size24 ? .size12 : .size16, currency: currency, decimalStyle: .normal, amount: previousPricePrice < 0 ? abs(previousPricePrice) : previousPricePrice)
        }

        let andesMoneyAmount = AndesMoneyAmount(type: .positive, size: size == .size24 ? .size24 : .size36, currency: currency, decimalStyle: .normal, amount: price)

        let config = AndesMoneyAmountComboViewConfig(
            size: size,
            moneyAmount: andesMoneyAmount,
            discount: andesMoneyAmountDiscount,
            previous: andesMoneyAmountPrevious)

        return config
    }
}
