//
//  AndesRadioButtonGroupDistribution.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 10/06/21.
//

import Foundation

@objc public enum AndesRadioButtonGroupDistribution: Int, AndesEnumStringConvertible {
    case horizontal
    case vertical

    public static func keyFor(_ value: AndesRadioButtonGroupDistribution) -> String {
        switch value {
        case .horizontal: return "HORIZONTAL"
        case .vertical: return "VERTICAL"
        }
    }
}
