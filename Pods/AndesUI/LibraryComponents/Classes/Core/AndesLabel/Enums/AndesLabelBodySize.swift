//
//  AndesLabelBodySize.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc public enum AndesLabelBodySize: Int, AndesEnumStringConvertible {
    case bodyL
    case bodyM
    case bodyS
    case bodyXS

    var size: CGFloat {
        switch self {
        case .bodyL:
            return AndesFontSize.bodyL
        case .bodyM:
            return AndesFontSize.bodyM
        case .bodyS:
            return AndesFontSize.bodyS
        case .bodyXS:
            return AndesFontSize.bodyXS
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .bodyL:
            return AndesFontSizeLineHeight.bodyL
        case .bodyM:
            return AndesFontSizeLineHeight.bodyM
        case .bodyS:
            return AndesFontSizeLineHeight.bodyS
        case .bodyXS:
            return AndesFontSizeLineHeight.bodyXS
        }
    }

    public static func keyFor(_ value: AndesLabelBodySize) -> String {
        switch value {
        case .bodyL:
            return "BodyL"
        case .bodyM:
            return "BodyM"
        case .bodyS:
            return "BodyS"
        case .bodyXS:
            return "BodyXS"
        }
    }
}
