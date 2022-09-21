//
//  AndesButtonAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 27/07/21.
//

import Foundation

class AndesButtonAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesButton!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesButton else {
            fatalError("AndesButtonAccessibilityManager should recieve an AndesButton")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = view.isSpinnerOn ? view.text + "inProgress".localized() : view.text
        updateViewTraits()
    }

    func accessibilityActivated() {
        if !view.isSpinnerOn && view.isEnabled {
            view.sendActions(for: .touchUpInside)
        }
    }

    private func updateViewTraits() {
        if view.isEnabled {
            view.accessibilityTraits = .button
        } else {
            view.accessibilityTraits.formUnion([.button, .notEnabled])
        }
    }
}
