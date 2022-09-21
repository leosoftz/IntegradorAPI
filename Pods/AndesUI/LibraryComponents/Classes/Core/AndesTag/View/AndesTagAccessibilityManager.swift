//
//  AndesTagAccessibilityManager.swift
//  AndesUI
//
//  Created by Laura Milena Sarmiento Almanza on 5/08/22.
//

import Foundation

class AndesTagAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesTagSimpleView!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesTagSimpleView else {
            fatalError("AndesTagAccessibilityManager should recieve an AndesTagSimpleView")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.textLabel.accessibilityValue = view.config.type?.toString().localized()

        makeAnnouncement(type: .custom(notification: .layoutChanged, argument: view.textLabel))
    }

    func accessibilityActivated() {
        // Not needed
    }
}
