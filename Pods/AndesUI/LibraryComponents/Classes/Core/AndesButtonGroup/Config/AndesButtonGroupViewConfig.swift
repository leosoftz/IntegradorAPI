//
//  
//  AndesButtonGroupViewConfig.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation

/// used to define the ui of internal AndesButtonGroup views
internal struct AndesButtonGroupViewConfig {
    let buttonList: [AndesButton]
    let type: AndesButtonGroupType
    let distribution: AndesButtonGroupDistribution
    let align: AndesButtonGroupAlign

    init(type: AndesButtonGroupType = .fullWidth,
         distribution: AndesButtonGroupDistribution = .horizontal,
         align: AndesButtonGroupAlign = .left,
         buttonList: [AndesButton] = []) {
        self.type = type
        self.distribution = distribution
        self.align = align
        self.buttonList = buttonList
    }
}
