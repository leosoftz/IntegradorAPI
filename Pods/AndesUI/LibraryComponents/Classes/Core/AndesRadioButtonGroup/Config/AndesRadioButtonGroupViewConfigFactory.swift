//
//  
//  AndesRadioButtonGroupViewConfigFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

class AndesRadioButtonGroupViewConfigFactory {
    static func provideInternalConfig(distribution: AndesRadioButtonGroupDistribution, align: AndesRadioButtonAlign, selected: Int, radioButtons: [AndesRadioButtonItem]) -> AndesRadioButtonGroupViewConfig {
        let distribution = AndesRadioButtonGroupTypeFactory.provide(distribution)
        let radioButtons = AndesRadioButtonsGroupFactory.provide(radioButtons, with: align)

        let config = AndesRadioButtonGroupViewConfig(type: distribution, selected: selected, radioButtons: radioButtons)

        return config
    }
}
