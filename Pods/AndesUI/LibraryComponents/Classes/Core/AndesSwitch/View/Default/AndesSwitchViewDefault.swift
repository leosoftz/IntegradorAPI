//
//  
//  AndesSwitchViewDefault.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import Foundation

class AndesSwitchViewDefault: AndesSwitchAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesSwitchViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
