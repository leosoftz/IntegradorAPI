//
//  AndesBadgeIconHierarchy.swift
//  AndesUI
//
//  Created by Eden Torres on 01/11/2021.
//

import Foundation

/// Used to define the style of an AndesBadgeIcon
@objc public enum AndesBadgeIconHierarchy: Int, AndesEnumStringConvertible {
    case loud
    case secondary

    public static func keyFor(_ value: AndesBadgeIconHierarchy) -> String {
        switch value {
        case .loud: return "LOUD"
        case .secondary: return "SECONDARY"
        }
    }
}
