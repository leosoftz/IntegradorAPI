//
//  AndesThumbnailBadgeType.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 23/08/21.
//

import Foundation

enum AndesThumbnailBadgeType: Int, AndesEnumStringConvertible {
    case pill
    case icon
    case dot
    case hidden

    static func keyFor(_ value: AndesThumbnailBadgeType) -> String {
        switch value {
        case .pill: return "PILL"
        case .icon: return "ICON"
        case .dot: return "DOT"
        case .hidden: return "HIDDEN"
        }
    }
}
