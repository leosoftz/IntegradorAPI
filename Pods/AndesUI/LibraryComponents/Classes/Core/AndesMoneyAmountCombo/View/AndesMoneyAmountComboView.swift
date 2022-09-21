//
//  
//  AndesMoneyAmountComboView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesMoneyAmountCombo
 */
internal protocol AndesMoneyAmountComboView: UIView {
    func update(withConfig config: AndesMoneyAmountComboViewConfig)
}
