//
//  AndesButtonGroupPadding.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 16/03/22.
//

import Foundation

/// Used to define the padding of an AndesButtonGroup
@objc
public enum AndesButtonGroupPadding: Int, AndesEnumStringConvertible {
    case small
    case medium
    case large

    public static func keyFor(_ value: AndesButtonGroupPadding) -> String {
        switch value {
        case .small: return "SMALL"
        case .medium: return "MEDIUM"
        case .large: return "LARGE"
        }
    }
}
