//
//  AndesMoneyAmountDecimalStyle.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//

import Foundation

@objc public enum AndesMoneyAmountDecimalStyle: Int, AndesEnumStringConvertible {
    case none
    case normal
    case superScript
    public static func keyFor(_ value: AndesMoneyAmountDecimalStyle) -> String {
        switch value {
        case .none: return "NONE"
        case .normal: return "NORMAL"
        case .superScript: return "SUPERSCRIPT"
        }
    }
}
