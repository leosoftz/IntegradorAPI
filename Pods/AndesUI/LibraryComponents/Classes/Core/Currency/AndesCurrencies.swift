//
//  AndesCurrencies.swift
//  AndesUI-AndesUIResources
//
//  Created by Daniel Esteban Beltran Beltran on 20/09/21.
//

import Foundation

@objc
public protocol AndesCurrencies {
    var currencies: [String: AndesCurrencyInfo] { get }
    var sites: [String: AndesSiteInfo] { get }
    var currentSite: String { get }
}

@objc
public class AndesCurrencyInfo: NSObject {
    public let decimalSeparator: String
    public let thousandSeparator: String
    public let symbol: String
    public let decimalPlaces: String
    public let decimalName: String
    public let currencyName: String
    public let decimalNamePrural: String
    public let currencyNamePrural: String
    public let isCrypto: Bool
    public let icon: String

    public init(decimalSeparator: String,
                thousandSeparator: String,
                symbol: String,
                decimalPlaces: String,
                decimalName: String,
                currencyName: String,
                decimalNamePrural: String,
                currencyNamePrural: String,
                isCrypto: Bool,
                icon: String) {
        self.decimalSeparator = decimalSeparator
        self.thousandSeparator = thousandSeparator
        self.symbol = symbol
        self.decimalPlaces = decimalPlaces
        self.decimalName = decimalName
        self.currencyName = currencyName
        self.decimalNamePrural = decimalNamePrural
        self.currencyNamePrural = currencyNamePrural
        self.isCrypto = isCrypto
        self.icon = icon
    }
}

@objc
public class AndesSiteInfo: NSObject {
    var decimalSeparator: String
    var thousandSeparator: String

    public init(decimalSeparator: String, thousandSeparator: String) {
        self.decimalSeparator = decimalSeparator
        self.thousandSeparator = thousandSeparator
    }
}

extension AndesCurrencyInfo {
    /// Get info from currency
    public func currencyInfoWith(formatedCountry: AndesCountry?) -> AndesCurrencyInfo {
        let currentSite = AndesCurrenciesManager.currencies.currentSite
        let andesCountry = formatedCountry ?? AndesCountry.init(from: currentSite)

        guard let currentSiteCountry = andesCountry,
              let decimalSeparator = AndesCurrenciesManager.currencies.sites[currentSiteCountry.toString()]?.decimalSeparator,
              let thousandsSeparator = AndesCurrenciesManager.currencies.sites[currentSiteCountry.toString()]?.thousandSeparator
        else { return self }

        return AndesCurrencyInfo(
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandsSeparator,
            symbol: self.symbol,
            decimalPlaces: self.decimalPlaces,
            decimalName: self.decimalName,
            currencyName: self.currencyName,
            decimalNamePrural: self.decimalNamePrural,
            currencyNamePrural: self.currencyNamePrural,
            isCrypto: isCrypto,
            icon: self.icon
        )
    }
}
