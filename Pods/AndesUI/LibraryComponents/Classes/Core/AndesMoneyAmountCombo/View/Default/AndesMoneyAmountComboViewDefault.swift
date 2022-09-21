//
//  
//  AndesMoneyAmountComboViewDefault.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

class AndesMoneyAmountComboViewDefault: AndesMoneyAmountComboAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesMoneyAmountComboViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
