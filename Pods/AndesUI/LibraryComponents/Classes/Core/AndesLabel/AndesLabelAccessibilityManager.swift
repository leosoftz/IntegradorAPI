//
//  AndesLabelAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 9/11/21.
//

import Foundation

class AndesLabelAccessibilityManager: AndesAccessibilityManager {
    private var view: AndesLabel

    private var a11yText: String

    required init(view: UIView) {
        guard let accessibleView = view as? AndesLabel else {
            fatalError("AndesLabelAccessibilityManager should recieve an AndesLabel")
        }
        self.view = accessibleView
        self.a11yText = ""
    }

    func viewUpdated() {
        view.accessibilityTraits = .staticText

        view.accessibilityLabel = self.a11yText
        view.accessibilityHint = view.bodyLinks?.links.count ?? 0 > 0 ? "links disponibles, doble tap para listarlos".localized() : ""
    }

    func accessibilityActivated() {
        guard let links = view.bodyLinks, let text = view.text else { return }
        makeAnnouncementWithLinks(text, links)
    }

    public func clearA11yText() {
        self.a11yText = ""
        self.viewUpdated()
    }

    public func addToA11y(text: String) {
        self.a11yText = self.a11yText + text
        self.viewUpdated()
    }
}
