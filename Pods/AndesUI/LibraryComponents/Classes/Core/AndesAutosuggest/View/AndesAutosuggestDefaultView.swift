//
//  AndesAutosuggestDefaultView.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 25/05/2021.
//

import UIKit

class AndesAutosuggestDefaultView: AndesAutosuggestAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesAutosuggestDefaultView", owner: self, options: nil)
    }
}
