//
//  
//  AndesSwitchType.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import Foundation

@objc public enum AndesSwitchType: Int, AndesEnumStringConvertible {
    case enable
    case disable

    public static func keyFor(_ value: AndesSwitchType) -> String {
        switch value {
        case .enable: return "ENABLED"
        case .disable: return "DISABLED"
        }
    }
}
