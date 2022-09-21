//
//  
//  AndesTabsViewConfigFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

internal class AndesTabsViewConfigFactory {
    static func provideInternalConfig(andesTabs: AndesTabs) -> AndesTabsViewConfig {
        let type = AndesTabsTypeFactory.provide(andesTabs.type)
        let config = AndesTabsViewConfig(type: type,
                                         style: AndesTabsStyle(),
                                         widthConstraint: andesTabs.bounds.width,
                                         tabsList: andesTabs.tabs,
                                         currentSelection: andesTabs.selectedTabPosition,
                                         fullWidthTab: type.fullWidthTab,
                                         dispatchQueue: andesTabs.dispatchQueue)

        return config
    }
}
