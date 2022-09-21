//
//  AndesTextFieldCodeAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 20/05/21.
//

import Foundation

class AndesTextFieldCodeAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesTextFieldCode!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesTextFieldCode else {
            fatalError("TextFieldCode AccessibilityManager should recieve an AndesTextFieldCode")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.accessibilityLabel = createAccessibilityLabel()
        updateAccessibilityNavigation()
    }

    func accessibilityActivated() {
        makeAnnouncement(type: .custom(notification: .layoutChanged, argument: view))
        view.setFocus()
    }

    private func updateAccessibilityNavigation() {
        view.isAccessibilityElement = true
        view.contentView.accessibilityElementsHidden = true
        view.contentView.isAccessibilityElement = false
        view.contentView.subviews.forEach { view in
            view.isAccessibilityElement = false
            view.accessibilityElementsHidden = true
        }
    }

    private func createAccessibilityLabel() -> String {
        "Campo de código, %@%@%@%@ caracteres ingresados: %d de %d".localizeWithFormat(arguments: labelText,
                                                                                           errorText,
                                                                                           numberText,
                                                                                           helperText,
                                                                                           view.text.count,
                                                                                           totalNumberCount)
    }
}

// MARK: - Accessibility label computed properties
private extension AndesTextFieldCodeAccessibilityManager {
    var labelText: String {
        if let labelText = view.label, labelText != "" {
            return " " + labelText + ", "
        }
        return ""
    }
    var errorText: String {
        view.state == .ERROR ? "error,".localized() : ""
    }
    var numberText: String {
        if view.text.count == .zero {
            return ""
        }
        return " " + view.text.map { String($0) }.joined(separator: " ") + ","
    }
    var helperText: String {
        if let helperText = view.helpLabel, helperText != "" {
            return " " + helperText + ","
        }
        return ""
    }

    var totalNumberCount: Int {
        switch view.style {
        case .THREESOME:
            return 3
        case .FOURSOME:
            return 4
        case .THREE_BY_THREE:
            return 6
        }
    }
}
