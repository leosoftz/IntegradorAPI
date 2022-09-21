//
//  AndesAmountFieldInputMode.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

@objc
public enum AndesAmountFieldInputMode: Int, AndesEnumStringConvertible {
    case fromDecimal
    case fromInteger

    public static func keyFor(_ value: AndesAmountFieldInputMode) -> String {
        switch value {
        case .fromDecimal: return "FROMDECIMAL"
        case .fromInteger: return "FROMINTEGER"
        }
    }
}
