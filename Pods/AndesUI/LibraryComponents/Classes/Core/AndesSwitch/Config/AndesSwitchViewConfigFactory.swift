//
//  AndesSwitchViewConfigFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 23/06/21.
//

import Foundation

internal class AndesSwitchViewConfigFactory {
    static func provideInternalConfig(andesSwitch: AndesSwitch) -> AndesSwitchViewConfig {
        return AndesSwitchViewConfig(
            type: AndesSwitchTypeFactory.provide(andesSwitch.type),
            status: andesSwitch.status,
            align: andesSwitch.align,
            text: andesSwitch.text,
            titleNumberOfLines: andesSwitch.titleNumberOfLines,
            isOn: andesSwitch.status == .checked)
    }
}
