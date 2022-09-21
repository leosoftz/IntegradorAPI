//
//  AndesSliderTypeLimits.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

internal struct AndesSliderTypeLimits: AndesSliderTypeProtocol {
    var leftIcon: String = ""
    var rightIcon: String = ""
    var minValue: String
    var maxValue: String

    init(minValue: String, maxValue: String) {
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
