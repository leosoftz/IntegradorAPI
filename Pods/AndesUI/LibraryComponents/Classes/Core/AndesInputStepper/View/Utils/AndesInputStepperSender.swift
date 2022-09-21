//
//  AndesInputStepperSender.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/**
 The AndesInputStepperSender contains the differents sender that a InputStepper supports
 */
@objc public enum AndesInputStepperSender: Int, AndesEnumStringConvertible {
    case previous
    case next

    public static func keyFor(_ value: AndesInputStepperSender) -> String {
        switch value {
        case .previous: return "PREVIOUS"
        case .next: return "NEXT"
        }
    }
}
