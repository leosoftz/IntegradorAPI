//
//  AndesLabelColor.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc public enum AndesLabelColor: Int, AndesEnumStringConvertible {
    case primary
    case secondary
    case disabled
    case negative
    case caution
    case positive
    case link

    public var color: UIColor {
        switch self {
        case .primary:
            return AndesStyleSheetManager.styleSheet.textColorPrimary
        case .secondary:
            return  AndesStyleSheetManager.styleSheet.textColorSecondary
        case .disabled:
            return  AndesStyleSheetManager.styleSheet.textColorDisabled
        case .negative:
            return AndesStyleSheetManager.styleSheet.textColorNegative
        case .caution:
            return AndesStyleSheetManager.styleSheet.textColorCaution
        case .positive:
            return AndesStyleSheetManager.styleSheet.textColorPositive
        case .link:
            return AndesStyleSheetManager.styleSheet.textColorLink
        }
    }

    public static func keyFor(_ value: AndesLabelColor) -> String {
        switch value {
        case .primary:
            return "Primary"
        case .secondary:
            return  "Secondary"
        case .disabled:
            return  "Disabled"
        case .negative:
            return "Negative"
        case .caution:
            return "Caution"
        case .positive:
            return "Positive"
        case .link:
            return "Link"
        }
    }
}
