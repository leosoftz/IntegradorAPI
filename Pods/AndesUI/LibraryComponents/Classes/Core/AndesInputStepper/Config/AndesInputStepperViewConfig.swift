//
//  AndesInputStepperViewConfig.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/// used to define the ui of internal AndesInputStepper views
internal struct AndesInputStepperViewConfig {
    var size: AndesInputStepperSizeProtocol
    var maxValue: Int
    var minValue: Int
    var step: Int
    var value: Int
}
