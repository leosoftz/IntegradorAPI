//
//  AndesFloatingMenuWidthType.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 22/06/2021.
//

import Foundation

@objc public enum  AndesFloatingMenuWidthType: Int, AndesEnumStringConvertible, CaseIterable {
    public static func keyFor(_ value: AndesFloatingMenuWidthType) -> String {
        switch value {
        case .fixed:
            return "FIXED"
        case .custom:
            return "CUSTOM"
        }
    }

    case fixed
    case custom
}
