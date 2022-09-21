//
//  AndesMoneyAmountPriceCurrencyInfoFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 26/08/21.
//

import Foundation

class AndesMoneyAmountCurrencyInfoObject {
    static func currencyInfoWith(_ currency: AndesCurrencyInfo, formatedCountry: AndesCountry) -> AndesCurrencyInfo? {
        let currentSite = AndesCurrenciesManager.currencies.currentSite
        let andesCountry = formatedCountry == .DEFAULT ? AndesCountry.init(from: currentSite) : formatedCountry

        guard let currentSiteCountry = andesCountry,
              let decimalSeparator = andesCountry == .DEFAULT ? currency.decimalSeparator : AndesCurrenciesManager.currencies.sites[currentSiteCountry.toString()]?.decimalSeparator,
              let thousandsSeparator = andesCountry == .DEFAULT ? currency.thousandSeparator : AndesCurrenciesManager.currencies.sites[currentSiteCountry.toString()]?.thousandSeparator
        else { return nil }

        return AndesCurrencyInfo(
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandsSeparator,
            symbol: currency.symbol,
            decimalPlaces: currency.decimalPlaces,
            decimalName: currency.decimalName,
            currencyName: currency.currencyName,
            decimalNamePrural: currency.decimalNamePrural,
            currencyNamePrural: currency.currencyNamePrural,
            isCrypto: currency.isCrypto,
            icon: currency.icon
        )
    }
}
