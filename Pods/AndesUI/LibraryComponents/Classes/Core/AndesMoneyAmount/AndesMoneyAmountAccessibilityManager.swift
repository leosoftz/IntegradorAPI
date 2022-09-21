//
//  
//  AndesMoneyAmountAccessibilityManager.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

class AndesMoneyAmountAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesMoneyAmount!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesMoneyAmount else {
            fatalError("AndesMoneyAmount AccessibilityManager should recieve an AndesMoneyAmount")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = createAccessibilityLabel(MoneyAmount: view)
    }

    func accessibilityActivated() {
        // not needed
    }

    private func createAccessibilityLabel(MoneyAmount: AndesMoneyAmount) -> String {
        guard let currencyInfo = AndesMoneyAmount.moneyAmountCurrencyInfo(for: view.currency, and: view.country) else { return "" }

        let currency = AndesMoneyAmountCurrencyFactory.provide(currencyInfo, view.decimalStyle, amount: view.amount, showZerosDecimal: view.showZerosDecimal)

        var accesibilityLabel: String = ""

        if view.type == .negative {
            accesibilityLabel = "Less".localized() + " "
        } else  if view.type == .previous {
            accesibilityLabel = "Previous".localized() + " "
        }

        accesibilityLabel += currencyFormatedForAccessibility(currency: currency)

        if let suffixAccesibility = view.suffixAccesibility {
            accesibilityLabel += ";" + suffixAccesibility
        }

        return accesibilityLabel
    }

    func currencyFormatedForAccessibility(currency: String) -> String {
        guard let currencyInfo = AndesMoneyAmount.moneyAmountCurrencyInfo(for: view.currency, and: view.country) else { return "" }
        var accesibilityLabel = ""
        var values: [String] = []
        let currencySplited = currency.split(separator: Character(currencyInfo.decimalSeparator))

        currencySplited.forEach { value in
            values.append(String(value))
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = NSLocale.current

        let integerValue = values.first?.replacingOccurrences(of: currencyInfo.thousandSeparator, with: "")
        let integersFormated = formatter.string(for: Double(integerValue ?? "0")) ?? "Invalid"
        let decimalsFormated = formatter.string(for: Double(values.last ?? "0")) ?? "Invalid"

        if currencyInfo.isCrypto {
            accesibilityLabel += "\(integersFormated) "

            if view.decimalStyle != .none, values.count > 1 {
                accesibilityLabel += "\("Con".localized()) \(values.last ?? "0") "
            }

            let isSingular = (Double(integerValue ?? "0") ?? 0) <= 1
            accesibilityLabel += isSingular ? currencyInfo.currencyName.localized() : currencyInfo.currencyNamePrural.localized()
            return accesibilityLabel
        }

        accesibilityLabel += "\(integersFormated) \(integersFormated == "1" ? currencyInfo.currencyName.localized() : currencyInfo.currencyNamePrural.localized())"

        if view.decimalStyle != .none, values.count > 1 {
            accesibilityLabel += "\(currencyInfo.decimalSeparator) \(decimalsFormated) \(decimalsFormated == "1" ? currencyInfo.decimalName.localized() : currencyInfo.decimalNamePrural.localized())"
        }

        return accesibilityLabel
    }
}
