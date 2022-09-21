//
//  
//  AndesMoneyAmountViewConfigFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

internal class AndesMoneyAmountViewConfigFactory {
    static func provideInternalConfig(type: AndesMoneyAmountType, currencyInfo: AndesCurrencyInfo, size: AndesMoneyAmountSize, decimalStyle: AndesMoneyAmountDecimalStyle, amount: Double?, showZerosDecimal: Bool) -> AndesMoneyAmountViewConfig {
        func getSizeFor(_ size: AndesMoneyAmountSize, isForSuperScript: Bool) -> CGFloat {
            let sizeString = AndesMoneyAmountSize.keyFor(size)

            if isForSuperScript, decimalStyle == .superScript {
                let superScriptSize = AndesMoneyAmountSize.superScriptSizeFor(size)
                return superScriptSize
            }

            guard let size = NumberFormatter().number(from: sizeString) else { return 0.0 }

            return CGFloat(truncating: size)
        }

        if currencyInfo.isCrypto && decimalStyle == .superScript {
            FatalErrorUtil.fatalErrorClosure("This decimal style is not valid for cryptocurrency", #file, #line)
        }

        let amount = ((amount ?? 0) < 0) ? abs(amount ?? 0) : amount ?? 0
        let currencyFactory = AndesMoneyAmountCurrencyFactory.provide(
            currencyInfo,
            decimalStyle,
            amount: amount,
            showZerosDecimal: showZerosDecimal
        )

        let amountFormated = "\(currencyInfo.symbol) \(currencyFactory)"

        let sizes = AndesMoneyAmountSizeInfo(
            labelSize: getSizeFor(size, isForSuperScript: false),
            superScripSize: getSizeFor(size, isForSuperScript: true)
        )

        let config = AndesMoneyAmountViewConfig(
            type: type,
            decimalStyle: decimalStyle,
            decimalSeparator: currencyInfo.decimalSeparator,
            amount: amountFormated,
            sizes: sizes
        )

        return config
    }
}
