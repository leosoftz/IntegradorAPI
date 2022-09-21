//
//  AndesLinearProgressIndicatorSize.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

/**
 The AndesLinearProgressIndicatorSize contains the differents sizes that a button supports
 */
@objc public enum AndesLinearProgressIndicatorSize: Int, AndesEnumStringConvertible {
    case large
    case small

    public static func keyFor(_ value: AndesLinearProgressIndicatorSize) -> String {
        switch value {
        case .large: return "LARGE"
        case .small: return "SMALL"
        }
    }
}
