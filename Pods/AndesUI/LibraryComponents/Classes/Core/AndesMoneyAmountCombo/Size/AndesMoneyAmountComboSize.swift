//
//  AndesMoneyAmountComboSize.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//

import Foundation

/// Used to define the size of an AndesMoneyAmountCombo
@objc public enum AndesMoneyAmountComboSize: Int, AndesEnumStringConvertible {
    case size24
    case size36

    public static func keyFor(_ value: AndesMoneyAmountComboSize) -> String {
        switch value {
        case .size24: return "24"
        case .size36: return "36"
        }
    }
}
