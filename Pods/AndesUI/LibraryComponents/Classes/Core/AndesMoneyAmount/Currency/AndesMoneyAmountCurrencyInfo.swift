//
//  AndesMoneyAmountDiscountCurrencyInfo.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 25/08/21.
//

import Foundation

@objc
protocol AndesMoneyAmountCurrencyInfo {
    var decimalSeparator: String { get }
    var thousandsSeparator: String { get }
    var currencySimbol: String { get }
    var decimalPlaces: Int { get }
}
