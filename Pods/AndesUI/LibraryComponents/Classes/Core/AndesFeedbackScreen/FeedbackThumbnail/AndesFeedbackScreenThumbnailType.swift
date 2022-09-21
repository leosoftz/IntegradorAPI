//
//  AndesFeedbackScreenThumbnailType.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 1/09/21.
//

import Foundation

enum AndesFeedbackScreenThumbnailType: Int, AndesEnumStringConvertible {
    case image
    case icon
    case iconWithoutBadge

    static func keyFor(_ value: AndesFeedbackScreenThumbnailType) -> String {
        switch value {
        case .image:
            return "IMAGE"
        case .icon:
            return "ICON"
        case .iconWithoutBadge:
            return "ICON_WITHOUT_BADGE"
        }
    }
}
