//
//  AndesRadioButtonAccessibilityManager.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 5/08/21.
//

import Foundation

class AndesRadioButtonAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesRadioButton!

    required init(view: UIView) {
        guard let radioButton = view as? AndesRadioButton else {
            fatalError("AndesRadioButtonAccessibilityManager should recieve an AndesRadioButton")
        }
        self.view = radioButton
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = createAccessibilityLabel(radioButton: view)
        view.accessibilityTraits = view.type != .disabled ? .none : .notEnabled
        view.accessibilityHint = radioButtonAccessibilityHint
    }

    func accessibilityActivated() {
        view.radioButtonTapped()
    }

    private func createAccessibilityLabel(radioButton: AndesRadioButton) -> String {
        var accessibilityLabel: String = ""
        accessibilityLabel += "\(radioButtonStatusAccessibilityText) \(radioButtonTitleAccessibilityText) \(radioButtonTypeAccessibilityText) \("Botón de selección".localized())"
        return accessibilityLabel
    }
}

extension AndesRadioButtonAccessibilityManager {
    var radioButtonTitleAccessibilityText: String {
        if let title = view.title {
            return title + ","
         }
         return ""
     }

    var radioButtonTypeAccessibilityText: String {
        view.type == .error ? "Error".localized() : ""
    }

    var radioButtonStatusAccessibilityText: String {
        switch view.status {
        case .selected:
            return "Marcado".localized()
        case .unselected:
            return "No Marcado".localized()
        }
    }

    var radioButtonAccessibilityHint: String {
        view.type != .disabled ? "Toque dos veces para alternar".localized() : ""
    }
}
