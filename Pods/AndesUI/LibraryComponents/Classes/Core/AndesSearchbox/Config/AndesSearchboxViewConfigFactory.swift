//
//  AndesSearchboxViewConfigFactory.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 21/05/2022.
//

import Foundation

internal class AndesSearchboxViewConfigFactory {
    static func provideInternalConfig(placeholder: String, state: AndesSearchboxState) -> AndesSearchboxViewConfig {
        let newState = AndesSearchboxStateFactory.provide(state)

        let config = AndesSearchboxViewConfig(placeHolder: placeholder, state: newState)
        return config
    }
}
