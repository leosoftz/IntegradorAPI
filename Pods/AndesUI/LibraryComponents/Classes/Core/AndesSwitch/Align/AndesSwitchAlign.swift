//
//  AndesSwitchAlign.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//

import Foundation

@objc public enum AndesSwitchAlign: Int, AndesEnumStringConvertible {
    case left
    case right

    public static func keyFor(_ value: AndesSwitchAlign) -> String {
        switch value {
        case .left: return "LEFT"
        case .right: return "RIGHT"
        }
    }
}
