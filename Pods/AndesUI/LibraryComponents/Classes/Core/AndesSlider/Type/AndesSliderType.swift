//
//  
//  AndesSliderType.swift
//  AndesUI
//
//  Created by Victor Chang on 25/02/2021.
//
//

import Foundation

/// Used to define the colors of an AndesSlider
@objc public enum AndesSliderType: Int, AndesEnumStringConvertible {
    case simple
    case icons
    case limits

    public static func keyFor(_ value: AndesSliderType) -> String {
        switch value {
        case .simple: return "SIMPLE"
        case .icons: return "ICONS"
        case .limits: return "LIMITS"
        }
    }
}
