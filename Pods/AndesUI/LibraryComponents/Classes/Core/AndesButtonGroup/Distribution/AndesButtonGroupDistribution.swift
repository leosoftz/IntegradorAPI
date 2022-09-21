//
//  
//  AndesButtonGroupHierarchy.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation

/// Used to define the style of an AndesButtonGroup
@objc
public enum AndesButtonGroupDistribution: Int, AndesEnumStringConvertible {
    case horizontal
    case vertical

    public static func keyFor(_ value: AndesButtonGroupDistribution) -> String {
        switch value {
        case .horizontal: return "HORIZONTAL"
        case .vertical: return "VERTICAL"
        }
    }
}
