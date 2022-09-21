//
//  AndesLinearProgressIndicatorViewConfigFactory.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

internal class AndesLinearProgressIndicatorViewConfigFactory {
    static func provideInternalConfig(
        indicatorTint: UIColor?,
        trackTint: UIColor?,
        isSplit: Bool?,
        numberOfSteps: Int?,
        size: AndesLinearProgressIndicatorSize) -> AndesLinearProgressIndicatorViewConfig {
        func resolveNumberOfSteps(numberOfSteps: Int?) -> Int {
            if let numberOfSteps = numberOfSteps, case  DefaultsLinearProgress.minNumberOfSteps...DefaultsLinearProgress.maxNumberOfSteps = numberOfSteps {
                return numberOfSteps
            } else {
                fatalError("numberOfSteps : Value between \(DefaultsLinearProgress.minNumberOfSteps) and \(DefaultsLinearProgress.maxNumberOfSteps)")
            }
        }

        let size = AndesLinearProgressIndicatorSizeFactory.provideStyle(key: size)
        let numberOfSteps = resolveNumberOfSteps(numberOfSteps: numberOfSteps)

        let config = AndesLinearProgressIndicatorViewConfig(
            indicatorTint: indicatorTint,
            trackTint: trackTint,
            isSplit: isSplit,
            numberOfSteps: numberOfSteps,
            size: size)

        return config
    }
}
