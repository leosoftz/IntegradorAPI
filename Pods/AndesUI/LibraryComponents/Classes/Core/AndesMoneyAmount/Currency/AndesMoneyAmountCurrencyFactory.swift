//
//  AndesMoneyAmountCurrencyFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//

import Foundation

class AndesMoneyAmountCurrencyFactory {
    static func provide(_ currencyInfo: AndesCurrencyInfo, _ decimalStyle: AndesMoneyAmountDecimalStyle, amount: Double?, showZerosDecimal: Bool) -> String {
        var amounIntFormated: Int = 0

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = currencyInfo.decimalSeparator
        formatter.groupingSeparator = currencyInfo.thousandSeparator
        formatter.maximumFractionDigits = Int(currencyInfo.decimalPlaces) ?? 0
        formatter.minimumFractionDigits = Int(currencyInfo.decimalPlaces) ?? 0

        if decimalStyle == .none {
            amounIntFormated = Int(amount ?? 0)
        }

        var formatedString = formatter.string(for: decimalStyle == .none ? amounIntFormated : amount) ?? "Invalid"

        if showZerosDecimal, !formatedString.contains(currencyInfo.decimalSeparator) {
            let decimals = Int(currencyInfo.decimalPlaces) ?? 0

            // validation to avoid a crash in the range
            if decimals > 1 {
                formatedString += "\(currencyInfo.decimalSeparator)"

                for _ in 1...decimals {
                    formatedString += "0"
                }
            }
        }

        let arrayOfAmountItems = formatedString.components(separatedBy: currencyInfo.decimalSeparator)

        let decimalNumber = Int(arrayOfAmountItems.last ?? "") ?? -1
        if decimalNumber == 0 && !showZerosDecimal {
            return arrayOfAmountItems.first ?? ""
        }

        return formatedString
    }
}
