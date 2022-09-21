//
//  
//  AndesRadioButtonGroupViewDefault.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

class AndesRadioButtonGroupViewDefault: AndesRadioButtonGroupAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesRadioButtonGroupViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
