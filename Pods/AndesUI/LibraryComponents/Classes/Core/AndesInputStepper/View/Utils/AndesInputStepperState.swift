//
//  AndesInputStepperState.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/**
 The AndesInputStepperState contains the differents states that a InputStepper supports
 */
@objc public enum AndesInputStepperState: Int, AndesEnumStringConvertible {
    case inRange
    case maxSelected
    case minSelected

    public static func keyFor(_ value: AndesInputStepperState) -> String {
        switch value {
        case .inRange: return "IN_RANGE"
        case .maxSelected: return "MAX_SELECTED"
        case .minSelected: return "MIN_SELECTED"
        }
    }
}
