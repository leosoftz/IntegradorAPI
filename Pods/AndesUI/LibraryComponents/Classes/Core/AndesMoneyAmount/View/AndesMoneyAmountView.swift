//
//  
//  AndesMoneyAmountView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesMoneyAmount
 */
internal protocol AndesMoneyAmountView: UIView {
    func update(withConfig config: AndesMoneyAmountViewConfig, andCurrencyAdditionalOptionalConfig helperConfig: CurrencyAdditionalOptionalConfig)
    func attText() -> NSAttributedString
}
