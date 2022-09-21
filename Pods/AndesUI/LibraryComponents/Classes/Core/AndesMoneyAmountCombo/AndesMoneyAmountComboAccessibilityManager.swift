//
//  
//  AndesMoneyAmountComboAccessibilityManager.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

class AndesMoneyAmountComboAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesMoneyAmountCombo!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesMoneyAmountCombo else {
            fatalError("AndesMoneyAmountCombo AccessibilityManager should recieve an AndesMoneyAmountCombo")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = createAccessibilityLabel(moneyAmount: view)
    }

    func accessibilityActivated() {
        // not needed
    }

    private func createAccessibilityLabel(moneyAmount: AndesMoneyAmountCombo) -> String {
        guard let  content = moneyAmount.contentView as? AndesMoneyAmountComboAbstractView
              else { return " " }

        return "\(moneyAmountPrice(content: content)) \(moneyAmountDiscount(content: content)) \(moneyAmountPrevious(content: content))"
    }

    private func moneyAmountPrice(content: AndesMoneyAmountComboAbstractView) -> String {
        if let price = content.config.moneyAmount.accessibilityLabel {
            return "\("now".localized()): \(price), "
        }
        return ""
    }

    private func moneyAmountDiscount(content: AndesMoneyAmountComboAbstractView) -> String {
        if let moneyAmount = content.config.discount, let discount = moneyAmount.accessibilityLabel {
            return "\(discount), "
        }
        return ""
    }

    private func moneyAmountPrevious(content: AndesMoneyAmountComboAbstractView) -> String {
        if let moneyAmount = content.config.previous, let price = moneyAmount.accessibilityLabel {
            return "\(price)"
        }
        return ""
    }
}
