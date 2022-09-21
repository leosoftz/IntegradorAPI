//
//  AndesMoneyAmountViewHelperConfigFactory.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 2/03/22.
//

import Foundation

internal enum CurrencyAdditionalOptionalConfigFactory {
    static func provideInternalConfig(currencyInfo: AndesCurrencyInfo,
                                      size: AndesMoneyAmountSize,
                                      suffix: NSMutableAttributedString?,
                                      textColor: UIColor?,
                                      showIcon: Bool,
                                      semiBold: Bool) -> CurrencyAdditionalOptionalConfig {
        let currencyIcon = AndesMoneyAmountCurrencyIcon(
            currencyIcon: currencyInfo.icon,
            currencyIconSize: AndesMoneyAmountSize.currencyIconSizeFor(size),
            currencyIconPadding: AndesMoneyAmountSize.currencyIconPaddingFor(size)
        )

        let suffixData = AndesMoneyAmountSuffix(
            suffix: suffix,
            suffixSize: AndesMoneyAmountSize.suffixSizeFor(size),
            suffixPadding: AndesMoneyAmountSize.suffixPaddingFor(size)
        )

        let config = CurrencyAdditionalOptionalConfig(
            currencyIcon: currencyIcon,
            showIcon: showIcon,
            suffix: suffixData,
            textColor: textColor,
            semiBold: semiBold
        )

        return config
    }
}
