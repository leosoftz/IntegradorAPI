//
//  
//  AndesTabsViewDefault.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

class AndesTabsViewDefault: AndesTabsAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesTabsViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
