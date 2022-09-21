//
//  AndesInputStepperViewConfigFactory.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

internal class AndesInputStepperViewConfigFactory {
    static func provideInternalConfig(
        size: AndesInputStepperSize,
        maxValue: Int,
        minValue: Int,
        step: Int,
        value: Int) -> AndesInputStepperViewConfig {
            checkMaxValue(maxValue: maxValue, minValue: minValue)
            checkMinValue(maxValue: maxValue, minValue: minValue)
            checkStepValue(stepValue: step)
            let size = AndesInputStepperSizeFactory.provideStyle(key: size)
            let config = AndesInputStepperViewConfig(
                size: size,
                maxValue: maxValue,
                minValue: minValue,
                step: step,
                value: value)

            return config
        }

    private static func checkMaxValue(maxValue: Int, minValue: Int) {
        if maxValue <= minValue {
            fatalError("maxValue must be greater than minvalue")
        }
    }

    private static func checkMinValue(maxValue: Int, minValue: Int) {
        if minValue >= maxValue {
            fatalError("minValue must be less than maxValue")
        }
    }

    private static func checkStepValue(stepValue: Int) {
        if stepValue < DefaultsInputStepper.step {
            fatalError("maxValue must be greater than or equal to 1")
        }
    }
}
