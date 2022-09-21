//
//  AndesSliderViewConfigFactory.swift
//  AndesUI
//
//  Created by Victor Chang on 27/04/2021.
//

import Foundation

internal class AndesSliderViewConfigFactory {
    static func provideInternalConfig(forContinuousSlider slider: AndesContinuousSlider) -> AndesSliderViewConfig {
        let value = slider.value
        let valueText = slider.valueText
        let minValue = slider.sliderMinValue ?? 0
        let maxValue = slider.sliderMaxValue ?? 100
        let leftIcon = slider.leftIcon
        let rightIcon = slider.rightIcon
        let type = slider.type
        let tooltipEnabled = slider.tooltipEnabled
        let state = slider.state

        return AndesSliderViewConfig(value, valueText: valueText, minValue: minValue, maxValue: maxValue, leftIconImageName: leftIcon, rightIconImageName: rightIcon, type: type, isTooltipEnabled: tooltipEnabled, state: state)
    }

    static func provideInternalConfig(forSteppedSlider slider: AndesSteppedSlider) -> AndesSliderViewConfig {
        let value = slider.value
        let valueText = slider.valueText
        let minValue = slider.sliderMinValue ?? 0
        let maxValue = slider.sliderMaxValue ?? 100
        let numberOfSteps = slider.numberOfSteps ?? 0
        let leftIcon = slider.leftIcon
        let rightIcon = slider.rightIcon
        let type = slider.type
        let tooltipEnabled = slider.tooltipEnabled
        let state = slider.state

        return AndesSliderViewConfig(value, valueText: valueText, minValue: minValue, maxValue: maxValue, leftIconImageName: leftIcon, rightIconImageName: rightIcon, type: type, isTooltipEnabled: tooltipEnabled, numberOfSteps: numberOfSteps, state: state)
    }
}
