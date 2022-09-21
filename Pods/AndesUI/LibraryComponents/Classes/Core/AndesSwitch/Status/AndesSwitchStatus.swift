//
//  AndesSwitchStatus.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//

import Foundation

@objc public enum AndesSwitchStatus: Int, AndesEnumStringConvertible {
    case checked
    case unchecked

    public static func keyFor(_ value: AndesSwitchStatus) -> String {
        switch value {
        case .checked: return "CHECKED"
        case .unchecked: return "UNCHECKED"
        }
    }
}
