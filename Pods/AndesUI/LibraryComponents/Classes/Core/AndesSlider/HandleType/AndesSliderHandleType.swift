//
//  AndesSliderHandleType.swift
//  AndesUI
//
//  Created by Victor Chang on 29/04/2021.
//

import Foundation

@objc public enum AndesSliderHandleType: Int, AndesEnumStringConvertible {
    case singleType
    case rangeType

    public static func keyFor(_ value: AndesSliderHandleType) -> String {
        switch value {
            case .singleType: return "SINGLE_TYPE"
            case .rangeType: return "RANGE_TYPE"
        }
    }
}
