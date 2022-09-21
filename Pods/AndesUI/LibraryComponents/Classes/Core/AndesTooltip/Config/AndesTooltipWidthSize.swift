//
//  AndesTooltipWidthSize.swift
//  AndesUI
//
//  Created by Vicente Veltri on 08/04/2021.
//

import Foundation

@objc public enum AndesTooltipWidthSize: Int, AndesEnumStringConvertible {
    case dynamic
    case fullSize

    public static func keyFor(_ value: AndesTooltipWidthSize) -> String {
        switch value {
        case .dynamic: return "dynamic"
        case .fullSize: return "fullSize"
        }
    }
}
