//
//  
//  AndesRadioButtonGroupViewConfig.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

/// used to define the ui of internal AndesRadioButtonGroup views
struct AndesRadioButtonGroupViewConfig {
    var distribution: AndesRadioButtonGroupTypeProtocol
    var selected: Int
    var radioButtons: [AndesRadioButton]

    init() {
        distribution = AndesRadioButtonGroupTypeVertical()
        selected = -1
        radioButtons = []
    }

    init(type: AndesRadioButtonGroupTypeProtocol, selected: Int, radioButtons: [AndesRadioButton]) {
        self.distribution = type
        self.selected = selected
        self.radioButtons = radioButtons
    }
}
