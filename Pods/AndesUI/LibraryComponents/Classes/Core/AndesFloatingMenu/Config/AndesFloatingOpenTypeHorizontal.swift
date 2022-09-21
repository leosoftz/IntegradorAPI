//
//  AndesFloatingOpenTypeHorizontal.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 22/06/2021.
//

import Foundation

@objc public enum  AndesFloatingOpenTypeHorizontal: Int, AndesEnumStringConvertible {
    public static func keyFor(_ value: AndesFloatingOpenTypeHorizontal) -> String {
        switch value {
        case .right:
            return "RIGHT"
        case .left:
            return "LEFT"
        }
    }

    case right
    case left
}
