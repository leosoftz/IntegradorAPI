//
//  
//  AndesTabsAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

class AndesTabsAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesTabs!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesTabs else {
            fatalError("AndesTabs AccessibilityManager should recieve an AndesTabs")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        (view.contentView as? AndesTabsAbstractView)?.tabsViews.enumerated().forEach {
            $0.element.isAccessibilityElement = true
            var accessibilityLabel: String = self.view.selectedTabPosition == $0.offset ? "TabSelected".localized() : ""
            accessibilityLabel += $0.element.tabTitle.text ?? ""
            accessibilityLabel += "TabDescription".localized()
            accessibilityLabel += "CurrentStatus".localizeWithFormat(arguments: $0.offset + 1, view.tabs.count)
            $0.element.accessibilityLabel = accessibilityLabel
        }
    }

    func accessibilityActivated() {
        // Not needed
    }
}
