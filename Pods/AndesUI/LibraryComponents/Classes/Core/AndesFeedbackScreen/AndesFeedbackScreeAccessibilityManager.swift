//
//  AndesFeedbackScreeAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 13/09/21.
//

import Foundation

class AndesFeedbackScreenAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesFeedbackScreenView!
    required init(view: UIView) {
        guard let feedbackScreen = view as? AndesFeedbackScreenView else {
            fatalError("AndesFeedbackScreeAccessibilityManager should recieve an AndesFeedbackScreenView")
        }
        self.view = feedbackScreen
        viewUpdated()
    }

    func viewUpdated() {
        setupCloseButtonAccessibility()
        setupTextViewAccessibility()
    }

    func accessibilityActivated() {
        // Not needed
    }

    private func setupTextViewAccessibility() {
        guard let textView = textBaseView() else { return }
        textView.descriptionTextView.isEditable = true
        textView.titleLabel.accessibilityTraits = .header
        textView.descriptionTextView.accessibilityTraits = .staticText
        makeAnnouncement(type: .custom(notification: .layoutChanged, argument: textView.overlineMode ? textView.overlineLabel : textView.titleLabel))
    }

    private func setupCloseButtonAccessibility() {
        view.closeButtonContainer?.isAccessibilityElement = true
        view.closeButtonContainer?.accessibilityLabel = "Cerrar".localized()
        view.closeButtonContainer?.accessibilityTraits = .button
    }

    private func textBaseView() -> AndesFeedbackScreenViewTextBase? {
        var baseTextView: AndesFeedbackScreenViewTextBase?
        func getSubview(view: UIView) {
            if let view = view as? AndesFeedbackScreenViewTextBase {
                baseTextView = view
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self.view)
        return baseTextView
    }
}
