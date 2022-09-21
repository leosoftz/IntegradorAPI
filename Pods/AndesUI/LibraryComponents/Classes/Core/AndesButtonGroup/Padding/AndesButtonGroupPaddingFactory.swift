//
//  AndesButtonGroupPaddingFactory.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 16/03/22.
//

import Foundation

internal class AndesButtonGroupPaddingFactory {
    static func provide(_ buttonSize: AndesButtonSize) -> AndesButtonGroupPaddingProtocol {
        switch buttonSize {
        case .small:
            return AndesButtonGroupSmallPadding()
        case .medium:
            return AndesButtonGroupMediumPadding()
        case .large:
            return AndesbuttonGroupLargePadding()
        }
    }
}
