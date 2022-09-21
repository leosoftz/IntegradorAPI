//
//  AndesCheckboxAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 4/08/21.
//

import UIKit

class AndesCheckboxAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesCheckbox!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesCheckbox else {
            fatalError("AndesCheckboxAccessibilityManager should recieve an AndesCheckbox")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = "\(checkboxStatusAccessibilityText), \(view.title ?? ""), \(checkboxTypeAccessibilityText), \("Casilla de selección".localized())"
        view.accessibilityTraits = view.type != .disabled ? .none : .notEnabled
        view.accessibilityHint = checkboxAccessibilityHint
    }

    func accessibilityActivated() {
        view.checkboxTapped()
    }
}

extension AndesCheckboxAccessibilityManager {
    var checkboxStatusAccessibilityText: String {
        switch view.status {
        case .selected:
            return "Marcado".localized()
        case .unselected:
            return "No Marcado".localized()
        case .undefined:
            return "Sin definir".localized()
        }
    }

    var checkboxTypeAccessibilityText: String {
        view.type == .error ? "Error".localized() : ""
    }

    var checkboxAccessibilityHint: String {
        view.type != .disabled ? "Toque dos veces para alternar".localized() : ""
    }
}
