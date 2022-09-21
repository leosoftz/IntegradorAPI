//
//  AndesTextAreaAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 31/08/22.
//

import Foundation

class AndesTextAreaAccessibilityManager: AndesAccessibilityManager {
    private var view: AndesTextArea!

    required init(view: UIView) {
        guard let textArea = view as? AndesTextArea else {
            fatalError("TextArea AccessibilityManager should recieve an AndesTextArea")
        }
        self.view = textArea
        viewUpdated()
    }

    func viewUpdated() {
        view.contentView.accessibilityUserInputLabels = [labelText, helperText]
        view.contentView.accessibilityLabel = createAccessibilityLabel(textArea: view)
        view.contentView.accessibilityHint = (view.contentView as? AndesTextFieldAbstractView)?.helperLabel.accessibilityHint
        updateAccessibilityNavigation()
        checkCharactersForAnnouncement()
    }

    func accessibilityActivated() {
        guard let helperLinks = view.helperLinks, let helper = view.helper else { return }
        makeAnnouncementWithLinks(helper, helperLinks)
    }

    private func checkCharactersForAnnouncement() {
        let shouldSendAnnouncement = shouldSendAnnouncement(maximumNumberOfCharacters: Int(view.counter), viewTextCount: view.text.count)
        if shouldSendAnnouncement {
            let charactersRemainingMessage = "%d caracteres restantes".localizeWithFormat(arguments: Int(view.counter) - view.text.count)
            makeAnnouncement(type: .message(message: charactersRemainingMessage))
        }
    }

    private func updateAccessibilityNavigation() {
        view.contentView.accessibilityTraits = view.state.accessibilityTraits
        view.contentView.isAccessibilityElement = true

        if let textView = (view.contentView as? AndesTextAreaView)?.textView {
            view.accessibilityElements = [view.contentView,
                                          view.state == .readOnly ? nil : textView as Any].compactMap { $0 }
        } else {
            view.accessibilityElements = [view.contentView as Any]
        }
    }

    private func createAccessibilityLabel(textArea: AndesTextArea) -> String {
        var accessibilityLabel: String = ""

        switch textArea.state {
        case .idle, .disabled:
            accessibilityLabel += "\(labelText)" +
            " \(placeholder.isEmpty ? text : placeholder)" +
            " \(helperText)" +
            " \(characterCounterText)" +
            "Campo de texto".localized()
        case .readOnly:
            accessibilityLabel += "\(labelText)" +
            " \(placeholder.isEmpty ? text : placeholder)"
        case .error, .warning:
            accessibilityLabel += "\(labelText)" +
            " \(stateText)" +
            " \(placeholder.isEmpty ? text : placeholder)" +
            " \(helperText)" +
            " \(characterCounterText)" +
            "Campo de texto".localized()
        }
        return accessibilityLabel
    }
}

// MARK: - Accessibility label computed properties
private extension AndesTextAreaAccessibilityManager {
    var helperText: String {
        if let helperText = view.helper, helperText.isNotEmpty {
            return helperText + ","
        }
        return ""
    }

    var characterCounterText: String {
        if view.contentView != nil,
           view.text.count > .zero,
           view.counter > .zero {
            return "caracteres ingresados %d de %d, ".localizeWithFormat(arguments: view.text.count, view.counter)
        } else if view.counter > .zero {
            return "máximo número de caracteres:".localized() + " \(view.counter), "
        }
        return ""
    }

    var labelText: String {
        if let title = view.label,
           title.isNotEmpty {
            return title + ","
        }
        return ""
    }

    var stateText: String {
        if let stateText = view.state.accessibilityText {
            return stateText + ","
        }
        return ""
    }

    var placeholder: String {
        if let placeHolder = self.view.placeholder,
           view.contentView != nil,
           view.text.count == .zero {
            return placeHolder + ","
        }
        return ""
    }

    var text: String {
        if view.contentView != nil,
           !view.text.isEmpty {
            return view.text + ","
        }
        return ""
    }
}
