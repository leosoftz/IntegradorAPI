//
//  
//  AndesTabsViewConfig.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

struct AndesTabsViewConfig {
    var currentSelection: Int = 0
    var distribution: UIStackView.Distribution = .fill
    var textAlignment: NSTextAlignment = .center
    var style: AndesTabsStyle = AndesTabsStyle()
    var widthConstraint: CGFloat = UIScreen.main.bounds.width
    var fullWidthTab: Bool = true
    var tabsList: [AndesTabItem] = []
    var cornerRadius: CGFloat = 3
    var dispatchQueue: AndesDispatchQueueType = DispatchQueue.main

    init() {}

    init(type: AndesTabsTypeProtocol,
         style: AndesTabsStyle,
         widthConstraint: CGFloat,
         tabsList: [AndesTabItem],
         currentSelection: Int,
         fullWidthTab: Bool,
         dispatchQueue: AndesDispatchQueueType) {
        self.currentSelection = type.currentSelection
        self.distribution = type.distribution
        self.textAlignment = type.textAlignment
        self.style = style
        self.widthConstraint = widthConstraint
        self.tabsList = tabsList
        self.currentSelection = currentSelection
        self.fullWidthTab = fullWidthTab
        self.dispatchQueue = dispatchQueue
    }
}
