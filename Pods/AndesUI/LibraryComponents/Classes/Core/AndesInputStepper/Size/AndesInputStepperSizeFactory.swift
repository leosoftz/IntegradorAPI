//
//  AndesInputStepperSizeFactory.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/**
 The responsability of the factory is to provide the right size by providing the AndesInputStepperSize
 */
class AndesInputStepperSizeFactory {
    static func provideStyle(key: AndesInputStepperSize) -> AndesInputStepperSizeProtocol {
        switch key {
        case .large:
            return AndesInputStepperSizeLarge()
        case .small:
            return AndesInputStepperSizeSmall()
        }
    }
}
