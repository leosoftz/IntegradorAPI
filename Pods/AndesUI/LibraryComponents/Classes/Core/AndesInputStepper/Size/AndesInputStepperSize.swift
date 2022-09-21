//
//  AndesInputStepperSize.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/**
 The AndesInputStepperSize contains the differents sizes that a InputStepper supports
 */
@objc public enum AndesInputStepperSize: Int, AndesEnumStringConvertible {
    case large
    case small

    public static func keyFor(_ value: AndesInputStepperSize) -> String {
        switch value {
        case .large: return "LARGE"
        case .small: return "SMALL"
        }
    }
}
