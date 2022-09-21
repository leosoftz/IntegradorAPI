//
//  AndesLabelTitleSize.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc public enum AndesLabelTitleSize: Int, AndesEnumStringConvertible {
    case titleXL
    case titleL
    case titleM
    case titleS
    case titleXS

    var size: CGFloat {
        switch self {
        case .titleXL:
            return AndesFontSize.titleXL
        case .titleL:
            return AndesFontSize.titleL
        case .titleM:
            return AndesFontSize.titleM
        case .titleS:
            return AndesFontSize.titleS
        case .titleXS:
            return AndesFontSize.titleXS
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .titleXL:
            return AndesFontSizeLineHeight.titleXL
        case .titleL:
            return AndesFontSizeLineHeight.titleL
        case .titleM:
            return AndesFontSizeLineHeight.titleM
        case .titleS:
            return AndesFontSizeLineHeight.titleS
        case .titleXS:
            return AndesFontSizeLineHeight.titleXS
        }
    }

    public static func keyFor(_ value: AndesLabelTitleSize) -> String {
        switch value {
        case .titleXL:
            return "TitleXl"
        case .titleL:
            return "TitleL"
        case .titleM:
            return "TitleM"
        case .titleS:
            return "TitleS"
        case .titleXS:
            return "TitleXS"
        }
    }
}
