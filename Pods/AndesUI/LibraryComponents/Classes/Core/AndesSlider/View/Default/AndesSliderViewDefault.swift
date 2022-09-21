//
//  
//  AndesSliderViewDefault.swift
//  AndesUI
//
//  Created by Victor Chang on 25/02/2021.
//
//

import Foundation

class AndesSliderViewDefault: AndesSliderAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesSliderAbstractView", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
