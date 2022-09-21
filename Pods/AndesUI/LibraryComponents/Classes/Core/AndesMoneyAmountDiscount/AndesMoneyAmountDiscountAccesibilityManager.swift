//
//  AndesMoneyAmountAccesibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 6/09/21.
//

import Foundation

class AndesMoneyAmountDiscountAccesibilityManager: AndesAccessibilityManager {
    private weak var view: AndesMoneyAmountDiscount!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesMoneyAmountDiscount else {
            fatalError("AndesMoneyAmountDiscount AccessibilityManager should recieve an AndesMoneyAmountDiscount")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = "\(view.discountValue)% " + "OFF".localized()
    }

    func accessibilityActivated() {
        // not needed
    }
}
