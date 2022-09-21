//
//  AndesCardAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 23/09/21.
//

import Foundation

class AndesCardAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesCard!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesCard else {
            fatalError("AndesCardAccessibilityManager should recieve an AndesCard")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        guard let contentView = view.contentView, let titleContainer = (contentView as? AndesCardAbstractView)?.titleContainer, let userView = (contentView as? AndesCardAbstractView)?.userViewContainer  else { return }

        titleContainer.isAccessibilityElement = true
        titleContainer.accessibilityLabel = view.title
        titleContainer.accessibilityTraits = UIAccessibilityTraits.header

        var accessibilityElements: [UIView] = [contentView, userView]

        if let linkContainer = (contentView as? AndesCardWithLinkView)?.linkContainer {
            linkContainer.isAccessibilityElement = true
            linkContainer.accessibilityLabel = view.linkText
            linkContainer.accessibilityTraits = UIAccessibilityTraits.link
            accessibilityElements.append(linkContainer)
        }

        if view.isActionCard {
            addCardAccessibility(accessibilityElements: accessibilityElements)
        } else {
            removeCardAccessibility()
        }
    }

    func addCardAccessibility(accessibilityElements: [UIView]) {
        view.contentView.isAccessibilityElement = true
        view.contentView.accessibilityLabel = view.cardAccessibilityLabel != nil ? view.cardAccessibilityLabel : (view.title ?? "") + "CardSelected".localized()
        view.accessibilityElements = accessibilityElements
        view.isAccessibilityElement = false
    }

    func removeCardAccessibility() {
        view.contentView.isAccessibilityElement = false
        view.accessibilityElements = nil
        view.isAccessibilityElement = false
    }

    func accessibilityActivated() {
        // Not needed
    }
}
