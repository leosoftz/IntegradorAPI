//
//  
//  AndesTabsType.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

@objc public enum AndesTabsType: Int, AndesEnumStringConvertible {
    case fullWidth
    case leftAlign

    public static func keyFor(_ value: AndesTabsType) -> String {
        switch value {
        case .fullWidth: return "FULL_WIDTH"
        case .leftAlign: return "LEFT_ALIGN"
        }
    }
}
