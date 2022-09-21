//
//  AndesTooltipAccessibilityManager.swift
//  AndesUI
//
//  Created by Laura Milena Sarmiento Almanza on 21/07/22.
//

import Foundation

class AndesTooltipAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesTooltipAbstractView!

    required init(view: UIView) {
        guard let tooltip = view as? AndesTooltipAbstractView else {
            fatalError("AndesTooltipAccesibilityManager should recieve an AndesTooltipAbstractView")
        }
        self.view = tooltip
        viewUpdated()
    }

    func viewUpdated() {
        view.contentLabel.isAccessibilityElement = true
        view.contentLabel.accessibilityHint = view.contentLabel.text

        view.closeButton.isAccessibilityElement = true
    }

    func accessibilityActivated() {}

    func removeAccessibility(superView: UIView?) {
        self.view.isAccessibilityElement = false
        self.view.contentLabel.isAccessibilityElement = true
        self.view.closeButton.isAccessibilityElement = true
        self.makeAnnouncement(type: .custom(notification: .screenChanged, argument: superView))
    }
}
