//
//  
//  AndesMoneyAmountType.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

/// Used to define the type of an AndesMoneyAmount
@objc public enum AndesMoneyAmountType: Int, AndesEnumStringConvertible {
    case positive
    case negative
    case previous

    public static func keyFor(_ value: AndesMoneyAmountType) -> String {
        switch value {
        case .positive: return "POSITIVE"
        case .negative: return "NEGATIVE"
        case .previous: return "PREVIOUS"
        }
    }
}
