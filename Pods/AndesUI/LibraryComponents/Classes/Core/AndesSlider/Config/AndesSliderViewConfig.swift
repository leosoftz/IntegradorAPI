//
//
//  AndesSliderViewConfig.swift
//  AndesUI
//
//  Created by Victor Chang on 25/02/2021.
//
//

import Foundation

internal struct AndesSliderViewConfig {
    var leftIconImageName: String? = ""
    var rightIconImageName: String? = ""
    var value: Double! = 0
    var valueText: String?
    var minValue: Double! = 0
    var maxValue: Double! = 100
    var type: AndesSliderType = .simple
    var tooltipEnabled: Bool = false
    var numberOfSteps: Int?
    var state: AndesSliderState = .idle

    init() { }

    init(_ value: Double = 0, valueText: String? = nil, minValue: Double, maxValue: Double, leftIconImageName: String?, rightIconImageName: String?, type: AndesSliderType, isTooltipEnabled: Bool, state: AndesSliderState) {
        self.value = value
        self.valueText = valueText
        self.minValue = minValue
        self.maxValue = maxValue
        self.leftIconImageName = leftIconImageName
        self.rightIconImageName = rightIconImageName
        self.type = type
        self.tooltipEnabled = isTooltipEnabled
        self.state = state
    }

    init(_ value: Double = 0, valueText: String? = nil, minValue: Double, maxValue: Double, leftIconImageName: String?, rightIconImageName: String?, type: AndesSliderType, isTooltipEnabled: Bool, numberOfSteps: Int?, state: AndesSliderState) {
        self.value = value
        self.valueText = valueText
        self.minValue = minValue
        self.maxValue = maxValue
        self.leftIconImageName = leftIconImageName
        self.rightIconImageName = rightIconImageName
        self.type = type
        self.tooltipEnabled = isTooltipEnabled
        self.state = state
        self.numberOfSteps = numberOfSteps
    }
}
