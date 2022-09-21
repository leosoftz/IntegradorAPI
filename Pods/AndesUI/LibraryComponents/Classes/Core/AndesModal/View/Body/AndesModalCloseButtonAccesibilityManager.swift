//
//  AndesModalCloseButtonAccesibilityManager.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 8/06/22.
//

import Foundation

class AndesModalCloseButtonAccesibilityManager: AndesAccessibilityManager {
    private weak var button: UIButton!

    required init(view: UIView) {
        guard let button = view as? UIButton else {
            fatalError("\(self) should recieve an UIButton")
        }
        self.button = button
        viewUpdated()
    }

    func viewUpdated() {
        button.accessibilityLabel = "Cerrar".localized()
        button.accessibilityHint = "Toque dos veces para cerrar el modal".localized()
        updateViewTraits()
    }

    func accessibilityActivated() {
        if button.isEnabled {
            button.sendActions(for: .touchUpInside)
        }
    }

    private func updateViewTraits() {
        if button.isEnabled {
            button.accessibilityTraits = .button
        } else {
            button.accessibilityTraits.formUnion([.button, .notEnabled])
        }
    }
}
