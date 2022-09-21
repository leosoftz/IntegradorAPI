//
//  
//  AndesSliderTypeFactory.swift
//  AndesUI
//
//  Created by Victor Chang on 25/02/2021.
//
//

import Foundation

class AndesSliderTypeFactory {
    static func provide(_ type: AndesSliderType?, _ minValue: String, _ maxValue: String, leftIcon: String, rightIcon: String) -> AndesSliderTypeProtocol {
        switch type {
            case .simple:
                return AndesSliderTypeSimple()
            case .icons:
                return AndesSliderTypeIcons(leftIcon: leftIcon, rightIcon: rightIcon)
            case .limits:
                return AndesSliderTypeLimits(minValue: minValue, maxValue: maxValue)
            case .none:
                return AndesSliderTypeSimple()
        }
    }
}
