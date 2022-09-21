//
//  AndesFeedbackScreenIllustrationType.swift
//  AndesUI
//
//  Created by Romina Valeria Pozzuto on 21/03/2022.
//

import Foundation

@objc
public enum AndesFeedbackScreenIllustrationType: Int, AndesEnumStringConvertible {
    case small
    case medium
    case large

    public static func keyFor(_ value: AndesFeedbackScreenIllustrationType) -> String {
        switch value {
        case .small: return "SMALL"
        case .medium: return "MEDIUM"
        case .large: return "LARGE"
        }
    }

    public func size() -> CGSize {
        switch self {
        case .small:
            return CGSize(width: 320, height: 80)
        case .medium:
            return CGSize(width: 320, height: 128)
        case .large:
            return CGSize(width: 320, height: 160)
        }
    }
}
