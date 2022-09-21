//
//  
//  AndesButtonGroupViewConfigFactory.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation
import UIKit

internal class AndesButtonGroupViewConfigFactory {
    static func provideInternalConfig(type: AndesButtonGroupType, distribution: AndesButtonGroupDistribution, align: AndesButtonGroupAlign, buttonList: [AndesButton]) -> AndesButtonGroupViewConfig {
        let config = AndesButtonGroupViewConfig(type: type, distribution: distribution, align: align, buttonList: buttonList)

        return config
    }
}
