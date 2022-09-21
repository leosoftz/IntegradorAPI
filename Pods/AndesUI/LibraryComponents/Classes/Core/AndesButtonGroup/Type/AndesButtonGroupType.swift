//
//  
//  AndesButtonGroupType.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation

/// Used to define the colors of an AndesButtonGroup
@objc
public enum AndesButtonGroupType: Int, AndesEnumStringConvertible {
    case fullWidth
    case responsive

    public static func keyFor(_ value: AndesButtonGroupType) -> String {
        switch value {
        case .fullWidth: return "FULL_WIDTH"
        case .responsive: return "RESPONSIVE"
        }
    }
}
