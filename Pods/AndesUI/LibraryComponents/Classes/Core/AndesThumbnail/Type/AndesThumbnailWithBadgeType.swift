//
//  AndesThumbnailBadgeType.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 18/08/21.
//

import Foundation

@objc public enum AndesThumbnailWithBadgeType: Int, AndesEnumStringConvertible {
    case icon
    case imageCircle

    public static func keyFor(_ value: AndesThumbnailWithBadgeType) -> String {
        switch value {
        case .icon: return "ICON"
        case .imageCircle: return "IMAGE_CIRCLE"
        }
    }

    func thumbnailType() -> AndesThumbnailType {
        switch self {
        case .icon:
            return .icon
        case .imageCircle:
            return .imageCircle
        }
    }
}
