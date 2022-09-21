//
//  AndesModalActions.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 18/05/22.
//

import Foundation

internal class AndesModalActions: NSObject {
    internal let distribution: AndesButtonGroupDistribution
    internal let buttons: [AndesButton]

    internal init(buttons: [AndesButton] = [], distribution: AndesButtonGroupDistribution = .vertical) {
        self.buttons = buttons
        self.distribution = distribution
    }
}
