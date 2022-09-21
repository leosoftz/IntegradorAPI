//
//  AndesLinearProgressIndicatorSizeFactory.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

/**
 The responsability of the factory is to provide the right size by providing the AndesLinearProgressIndicatorSize
 */
class AndesLinearProgressIndicatorSizeFactory {
    static func provideStyle(key: AndesLinearProgressIndicatorSize) -> AndesLinearProgressIndicatorSizeProtocol {
        switch key {
        case .large:
            return AndesLinearProgressIndicatorSizeLarge()
        case .small:
            return AndesLinearProgressIndicatorSizeSmall()
        }
    }
}
